<?php
	define('SMARTY_DIR',__DIR__.'/../../libs/');
	require(SMARTY_DIR.'Smarty.class.php');
	
	class Smarty_FluentLogin extends Smarty {
	   function Smarty_FluentLogin() {
		    parent::__construct();
			
			$this->template_dir = __DIR__.'/templates/';
			$this->compile_dir = __DIR__.'/templates_c/';
			$this->config_dir = __DIR__.'/configs/';
			$this->cache_dir = __DIR__.'/cache/';
			
			$this->caching = true;
			$this->assign('app_name','fluentlogin');
	   }
	}
?>