<?php
	function minify($data,$json = false){
		$data = preg_replace('/\s+/', ' ', $data);
		if($json){
			$data = json_decode($data, true);
		}
		return $data;
	}
	
	$DIR_LIST = glob("*", GLOB_ONLYDIR);
	$Widgets  = array();
	for($i=0; $i<count($DIR_LIST); $i++)
	{
		if(file_exists($DIR_LIST[$i]."/manifest.json"))
		{
			$F_ = file_get_contents($DIR_LIST[$i]."/manifest.json");
			$F_ = minify($F_,true);
			$A_ = array();
			
			$A_["id"] 		= $F_["id"];
			$A_["dir"] 		= $DIR_LIST[$i];			
			$A_["name"] 	= $F_["name"];
			$A_["desc"] 	= $F_["desc"];
			if(!empty($F_["logo"])){
				$A_["logo"]	= $DIR_LIST[$i]."/".$F_["logo"];
			}else{
				$A_["logo"]	= "logo.png";
			}
			$A_["manifest"] = $DIR_LIST[$i]."/manifest.json";
			$Widgets[$A_["id"]]	= $A_;
		}
	}
	echo(json_encode($Widgets, JSON_UNESCAPED_UNICODE));
?>