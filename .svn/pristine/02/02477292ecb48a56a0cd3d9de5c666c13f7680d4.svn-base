	jQuery(function(){
    var kKeys = [];
    function Kpress(e){
        kKeys.push(e.keyCode);
        if (kKeys.toString().indexOf("38,38,40,40,37,39,37,39,66,65") >= 0) {
            jQuery(this).unbind('keydown', Kpress);
            kExec();
        }
    }
    jQuery(document).keydown(Kpress);
	});
	function kExec(){
		harlem();
	}
	
	
	function harlem() {
	
		var shake = new HarlemShake("headcontainer", { startAfter: 0, shakeStyle: "shake", applyToChild: false });
		var offset = 4000
		shake.add("manzana",{ startAfter: offset, shakeStyle: "flash" });
		shake.add("visual",{ startAfter: offset, shakeStyle: "bounce"});
		shake.add("intranet",{ startAfter: offset, shakeStyle: "wobble" });
		shake.add("crewlink",{ startAfter: offset, shakeStyle: "bounce" });
		shake.add("share",{	startAfter: offset,	shakeStyle: "tada" });
		shake.add("salesforce",{ startAfter: offset, shakeStyle: "swing"});
                shake.add("epapyruscm",{ startAfter: offset, shakeStyle: "bounce" });
                shake.add("email",{   startAfter: offset,     shakeStyle: "wobble"});
	//	shake.add("email2",{	startAfter: offset,	shakeStyle: "flip"});
		shake.add("records",{	startAfter: offset,	shakeStyle: "pulse"});
	//	shake.add("splunk",{	startAfter: offset,	shakeStyle: "flash"});
		shake.add("blog",{	startAfter: offset,	shakeStyle: "rotate"});
		shake.add("notilus",{	startAfter: offset,	shakeStyle: "bounce"});
		shake.add("ebiblio",{	startAfter: offset,	shakeStyle: "wobble"});
		shake.add("airshop",{	startAfter: offset,	shakeStyle: "tada"});
		shake.add("other",{	startAfter: offset,	shakeStyle: "flip"});
		shake.add("myid",{	startAfter: offset,	shakeStyle: "rotate"});
		shake.add("sso",{	startAfter: offset,	shakeStyle: "flip"});
		shake.add("colombus",{	startAfter: offset,	shakeStyle: "pulse"});
		shake.add("arp",{ startAfter: offset, shakeStyle: "wobble" });
	}
