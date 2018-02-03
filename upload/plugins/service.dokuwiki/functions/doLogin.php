<?php

	/* Account Service "DokuWiki"

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
	*/
//die("mit");
    global $userName;
    global $cleartextPassword;
    global $expiryTime;

    // Set up new session

    $dokucookie = "DWd6fcb57a725757b22fe830cccebe05e6";
    $secret = "df6fe2b4dba70deb44972b59c1c3a3b8ba9443093783fca097f2206f825f4c6060f16176a157af1f0dc47a8b61aa6aabff69a1b02479fb49064bc4eaa1ef5516";  // salt
    $sticky = false;

    if ($expiryTime > (time() + 40000)) {
        $sticky = true;
    }

    require(__DIR__ . "/../../../lib/phpseclib/Crypt_Base.php");
    require(__DIR__ . "/../../../lib/phpseclib/Crypt_Hash.php");
    require(__DIR__ . "/../../../lib/phpseclib/Crypt_Rijndael.php");
    require(__DIR__ . "/../../../lib/phpseclib/Crypt_AES.php");

    $iv     = auth_randombytes(16);
    $cipher = new Crypt_AES();
    $cipher->setPassword($secret);

    $passcrypt = $cipher->encrypt($iv.$cleartextPassword);

    $cookie = base64_encode($userName).'|'.((int) $sticky).'|'.base64_encode($passcrypt);

    setcookie($dokucookie, $cookie, $expiryTime, "/");


    // Additional functions ahead:

    /**
     * Return truly (pseudo) random bytes if available, otherwise fall back to mt_rand
     *
     * @author Mark Seecof
     * @author Michael Hamann <michael@content-space.de>
     * @link   http://www.php.net/manual/de/function.mt-rand.php#83655
     * @param int $length number of bytes to get
     * @return string binary random strings
     */
    function auth_randombytes($length) {
        $strong = false;
        $rbytes = false;

        if (function_exists('openssl_random_pseudo_bytes')
            && (version_compare(PHP_VERSION, '5.3.4') >= 0
                || strtoupper(substr(PHP_OS, 0, 3)) !== 'WIN')
        ) {
            $rbytes = openssl_random_pseudo_bytes($length, $strong);
        }

        if (!$strong && function_exists('mcrypt_create_iv')
            && (version_compare(PHP_VERSION, '5.3.7') >= 0
                || strtoupper(substr(PHP_OS, 0, 3)) !== 'WIN')
        ) {
            $rbytes = mcrypt_create_iv($length, MCRYPT_DEV_URANDOM);
            if ($rbytes !== false && strlen($rbytes) === $length) {
                $strong = true;
            }
        }

        // If no strong randoms available, try OS the specific ways
        if(!$strong) {
            // Unix/Linux platform
            $fp = @fopen('/dev/urandom', 'rb');
            if($fp !== false) {
                $rbytes = fread($fp, $length);
                fclose($fp);
            }

            // MS-Windows platform
            if(class_exists('COM')) {
                // http://msdn.microsoft.com/en-us/library/aa388176(VS.85).aspx
                try {
                    $CAPI_Util = new COM('CAPICOM.Utilities.1');
                    $rbytes    = $CAPI_Util->GetRandom($length, 0);

                    // if we ask for binary data PHP munges it, so we
                    // request base64 return value.
                    if($rbytes) $rbytes = base64_decode($rbytes);
                } catch(Exception $ex) {
                    // fail
                }
            }
        }
        if(strlen($rbytes) < $length) $rbytes = false;

        // still no random bytes available - fall back to mt_rand()
        if($rbytes === false) {
            $rbytes = '';
            for ($i = 0; $i < $length; ++$i) {
                $rbytes .= chr(mt_rand(0, 255));
            }
        }

        return $rbytes;
    }
?>
