<?php
/*

  UnscramblePHP v0.1.3 by RW Productions Software (aka idnaos from woborschil.de)
        Simplify your PHP code by shortening big repeating code blocks.
    Licensed under GNU LGPLv3: https://www.gnu.org/licenses/lgpl-3.0.en.html
                          Last Change: 2017/11/12

  =================================================================================
   ### CONFIGURATION ###
  =================================================================================

    $db_loginpath:
    Enter your MySQL login file here.
    For security reasons, this file should not be accessible from the Web
    nor placed in Git repositories.
    This file must contain the following variables:
      $db_host, $db_username, $db_password, $db_database

    */ $db_loginpath = __DIR__ . "/../../config.php"; /*

  =================================================================================
    End of configuration.
    Do not edit below this line unless you know what you're doing!
  =================================================================================
*/

    $conn = NULL;

    function db_conn() {
        global $conn;
        global $db_loginpath;
        global $db_database;

        if ($db_loginpath == "") {
            die("'db_loginpath' was not set in the configuration section of Unscramble.php!");
        }

        require($db_loginpath);
		$conn = new mysqli($db_host, $db_username, $db_password, "information_schema");
        $conn->set_charset("utf8");
    }

    function db_switch($db, $file, $line) {
        global $conn;

        $sql = "SELECT null FROM information_schema.SCHEMATA WHERE SCHEMA_NAME='$db'";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }

        if ($query->num_rows == 0) {
            db_err("Database '$db' doesn't exist", __FUNCTION__, $sql, $file, $line);
        }

        $conn->select_db($db);
    }

    function db_sel($select, $from, $where, $file, $line) {
        global $conn;
        global $query;
        $sql = "SELECT $select FROM $from WHERE $where";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }

        global $num_rows;
        $num_rows = $query->num_rows;

        while ($row = $query->fetch_assoc()) {
            if ($select != "*") {
                $cols = explode(", ", $select);
                foreach ($cols as $key => $value) {
                    $colval = $row[$value];
                    global ${"$value"};
                    ${"$value"} = $colval;
                }
            } else {
                $sql1 = "DESCRIBE $from";
                $query1 = $conn->query($sql1);
                if ($conn->error) {
                    db_err($conn->error, __FUNCTION__, $sql1, $file, $line);
                }

                while ($row1 = $query1->fetch_assoc()) {
                    $col = $row1["Field"];

                    $colval = $row[$col];
                    global ${"$col"};
                    ${"$col"} = $colval;
                }
            }
        }
    }

    function db_ins($table, $rows, $values, $file, $line) {
        global $conn;
        $sql = "INSERT INTO $table ($rows) VALUES ($values)";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }
    }

    function db_upd($table, $rowsvalues, $where, $file, $line) {
        global $conn;
        $sql = "UPDATE $table SET $rowsvalues WHERE $where";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }
    }

    function db_del($from, $where, $file, $line) {
        global $conn;
        $sql = "DELETE FROM $from WHERE $where";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }
    }

    function db_create_table($table, $colstypes, $file, $line) {
        global $conn;
        $sql = "CREATE TABLE $table($colstypes)";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }
    }

    function db_table_exists($db, $table, $file, $line) {
        global $conn;

        $sql = "SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='$db' && TABLE_NAME='$table'";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }

        if ($query->num_rows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    /*function db_get() {
        global $conn;
        $query = $conn->query("SELECT DATABASE()");
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }

        while ($row = $query->fetch_assoc()) {
            global $db;
            $db = $row["DATABASE()"];
        }
    }*/

    function db_get_ai($db, $table, $file, $line) {
        global $conn;
        //global $db;

        //db_get();
        $sql = "SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='$db' && TABLE_NAME='$table'";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }

        if ($query->num_rows == 0) {
            db_err("Table '$table' doesn't exist", __FUNCTION__, $sql, $file, $line);
        }

        while ($row = $query->fetch_assoc()) {
            global $ai;
            $ai = $row["AUTO_INCREMENT"];
        }
    }

    function db_set_ai($table, $ai, $file, $line) {
        global $conn;
        $sql = "ALTER TABLE $table auto_increment = $ai";
        $query = $conn->query($sql);
        if ($conn->error) {
            db_err($conn->error, __FUNCTION__, $sql, $file, $line);
        }
    }

    function db_san($get, $filter = "") {
        // SQL Sanitizer
        global $conn;

        if ($filter == "") {
            $nofilter = true;
        } else {
            $nofilter = false;
        }

        foreach ($get as $key => $value) {
            if ($nofilter) { $filter = $key; }  // empty filter should return true (and not false) in the next line

            if (is_array($value)) {  // otherwise problems with cookie arrays like "forum_mybb[...]"
                foreach ($value as $key1 => $value1) {
                    db_chk_san($key1, $value1, $filter);
                }

                break;
            }

            db_chk_san($key, $value, $filter);
        }
    }

    function db_chk_san($key, $value, $filter) {
        if (((strpos($value, "'") !== false) || (strpos($value, '"') !== false)) && (strpos($key, $filter) === 0)) {  // only search in filtered cookies
            die("Please remove any apostrophes or quotation marks from your request and try again.");
        }
    }

    function db_err($err, $func, $sql, $file, $line) {
        die("<p><b>SQL Error:</b> $err on <b>$func()</b>: \"$sql\" in <b>$file</b> on line <b>$line</b></p>");
    }
?>
