                (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                ga('create', 'UA-37058816-6', 'crl.aero');
                ga('send', 'pageview');
                ga('set', 'dimension1', '<!--#echo var="MELLON_firstname" -->');

				$(function() {
					$("a").on('click',function(e){
						var url = $(this).attr("href");
						if (e.currentTarget.host != window.location.host) {
							ga('send', 'event', 'link', 'click', url);
							if (e.metaKey || e.ctrlKey) {
								var newtab = true;
							}
							if (!newtab) {
								e.preventDefault();
								setTimeout('document.location = "' + url + '"', 100);
							}
						}
					});
				});