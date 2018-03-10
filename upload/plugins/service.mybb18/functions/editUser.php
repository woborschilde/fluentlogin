<?php

	/* Account Service "MyBB 1.8"

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
	*/
/*
    global $userName;
    global $userEmail;
    global $userPassword;
    global $serviceName;
    global $serviceDatabase;
    global $serviceTablePrefix;
    global $readonly;

    $stp = $serviceTablePrefix;

    // write your code here

    $salt = random_str(8);

    $salted_password = md5(md5($salt) . md5($userPassword));

    $loginkey = random_str(50);

    db_switch($serviceDatabase, __FILE__, __LINE__);

    db_sel("email", $stp . "users", "username='$userName'", __FILE__, __LINE__);

    $query = $conn->query("SELECT NULL FROM " . $stp . "users WHERE (username='$userName' || email='$userEmail')");

    if ($query->num_rows > 0) {
        die("A user with these credentials already exists in $serviceName!");
    }

    db_switch("fluentlogin", __FILE__, __LINE__);*/

    function mybb18_editUser() {

    }

    // Additional functions ahead:

    /**
     * Generates a random string.
     *
     * @author MyBB Group
     * @param int $length The length of the string to generate.
     * @param bool $complex Whether to return complex string. Defaults to false
     * @return string The random string.
     */
    function random_str($length=8, $complex=false)
    {
        $set = array_merge(range(0, 9), range('A', 'Z'), range('a', 'z'));
        $str = array();

        // Complex strings have always at least 3 characters, even if $length < 3
        if($complex == true)
        {
            // At least one number
            $str[] = $set[my_rand(0, 9)];

            // At least one big letter
            $str[] = $set[my_rand(10, 35)];

            // At least one small letter
            $str[] = $set[my_rand(36, 61)];

            $length -= 3;
        }

        for($i = 0; $i < $length; ++$i)
        {
            $str[] = $set[my_rand(0, 61)];
        }

        // Make sure they're in random order and convert them to a string
        shuffle($str);

        return implode($str);
    }

    /**
     * Wrapper function for mt_rand. Automatically seeds using a secure seed once.
     *
     * @author MyBB Group
     * @param int $min Optional lowest value to be returned (default: 0)
     * @param int $max Optional highest value to be returned (default: mt_getrandmax())
     * @param boolean $force_seed True forces it to reseed the RNG first
     * @return int An integer equivalent of a secure hexadecimal seed
     */
    function my_rand($min=null, $max=null, $force_seed=false)
    {
        static $seeded = false;
        static $obfuscator = 0;

        if($seeded == false || $force_seed == true)
        {
            mt_srand(secure_seed_rng());
            $seeded = true;

            $obfuscator = abs((int) secure_seed_rng());

            // Ensure that $obfuscator is <= mt_getrandmax() for 64 bit systems.
            if($obfuscator > mt_getrandmax())
            {
                $obfuscator -= mt_getrandmax();
            }
        }

        if($min !== null && $max !== null)
        {
            $distance = $max - $min;
            if($distance > 0)
            {
                return $min + (int)((float)($distance + 1) * (float)(mt_rand() ^ $obfuscator) / (mt_getrandmax() + 1));
            }
            else
            {
                return mt_rand($min, $max);
            }
        }
        else
        {
            $val = mt_rand() ^ $obfuscator;
            return $val;
        }
    }

    /**
     * Returns a securely generated seed for PHP's RNG (Random Number Generator)
     *
     * @author MyBB Group
     * @param int $count Length of the seed bytes (8 is default. Provides good cryptographic variance)
     * @return int An integer equivalent of a secure hexadecimal seed
     */
    function secure_seed_rng($count=8)
    {
        $output = '';
        // DIRECTORY_SEPARATOR checks if running windows
        if(DIRECTORY_SEPARATOR != '\\')
        {
            // Unix/Linux
            // Use OpenSSL when available
            if(function_exists('openssl_random_pseudo_bytes'))
            {
                $output = openssl_random_pseudo_bytes($count);
            }
            // Try mcrypt
            elseif(function_exists('mcrypt_create_iv'))
            {
                $output = mcrypt_create_iv($count, MCRYPT_DEV_URANDOM);
            }
            // Try /dev/urandom
            elseif(@is_readable('/dev/urandom') && ($handle = @fopen('/dev/urandom', 'rb')))
            {
                $output = @fread($handle, $count);
                @fclose($handle);
            }
        }
        else
        {
            // Windows
            // Use OpenSSL when available
            // PHP <5.3.4 had a bug which makes that function unusable on Windows
            if(function_exists('openssl_random_pseudo_bytes') && version_compare(PHP_VERSION, '5.3.4', '>='))
            {
                $output = openssl_random_pseudo_bytes($count);
            }
            // Try mcrypt
            elseif(function_exists('mcrypt_create_iv'))
            {
                $output = mcrypt_create_iv($count, MCRYPT_RAND);
            }
            // Try Windows CAPICOM before using our own generator
            elseif(class_exists('COM'))
            {
                try
                {
                    $CAPI_Util = new COM('CAPICOM.Utilities.1');
                    if(is_callable(array($CAPI_Util, 'GetRandom')))
                    {
                        $output = $CAPI_Util->GetRandom($count, 0);
                    }
                } catch (Exception $e) {
                }
            }
        }

        // Didn't work? Do we still not have enough bytes? Use our own (less secure) rng generator
        if(strlen($output) < $count)
        {
            $output = '';

            // Close to what PHP basically uses internally to seed, but not quite.
            $unique_state = microtime().@getmypid();

            for($i = 0; $i < $count; $i += 16)
            {
                $unique_state = md5(microtime().$unique_state);
                $output .= pack('H*', md5($unique_state));
            }
        }

        // /dev/urandom and openssl will always be twice as long as $count. base64_encode will roughly take up 33% more space but crc32 will put it to 32 characters
        $output = hexdec(substr(dechex(crc32(base64_encode($output))), 0, $count));

        return $output;
    }
?>
