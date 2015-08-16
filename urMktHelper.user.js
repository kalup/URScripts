// ==UserScript==
// @name           urMktHelper
// @namespace      http://userscripts.org/users/249211
// @include        http://www.urban-rivals.com/*/market/?show=0&action=buy&group=all&orderby=desc&sortby=date*
// @grant          GM_getValue
// @grant          GM_setValue
// @grant          GM_deleteValue
// @version        1
// @updateURL      https://github.com/kalup/URScripts/raw/master/urMktHelper.user.js
// ==/UserScript==

var k=GM_getValue("riskValue",0),l,m,n;0==k?(m=l=.9,n=.99):1==k?(l=.85,m=.86,n=.99):2==k?(l=.85,m=.86,n=.95):3==k?(l=.81,m=.82,n=.99):4==k?(l=.81,m=.82,n=.95):(l=.81,m=.82,n=.9);var r=GM_getValue("reloadTime",2E3),t=GM_getValue("imgDetectSafe",!0),u=GM_getValue("autoBuy",!1),v=GM_getValue("sound",!0),w=GM_getValue("isRunning",!1);GM_deleteValue("isRunning");function x(c){null!==c&&c.parentNode.removeChild(c)}
function D(c){var b=document.createElement("canvas"),a=b.getContext("2d");b.width=c.width;b.height=c.height;a.drawImage(c,0,0);return a.getImageData(0,0,b.width,b.height)}function E(c){c=c.width;return 14==c?2:21==c?3:35==c?4:42==c?5:49==c?6:63==c?7:70==c?8:9}function F(c){for(var b,a=c.width,e=c.height,d=c.data,h=0;h<a;++h)for(c=0;c<e;++c)b=4*h+4*c*a,200>d[b+3]&&(d[b]=255,d[b+1]=255,d[b+2]=255),d[b+3]=255,128<d[b+2]?(d[b]=255,d[b+1]=255,d[b+2]=255):(d[b]=0,d[b+1]=0,d[b+2]=0)}
function G(c,b){function a(a,c){return 0===e[4*(c+b+(a+4)*d)]}var e=c.data,d=c.width;return t?a(0,3)&&a(0,4)&&a(1,1)&&a(1,2)&&a(1,4)&&a(1,5)&&a(2,1)&&a(3,1)&&a(3,3)&&a(3,4)&&a(4,1)&&a(4,5)&&a(5,1)&&a(5,5)&&a(6,1)&&a(6,2)&&a(6,5)&&a(7,2)&&a(7,3)&&a(7,4)?6:a(0,2)&&a(0,3)&&a(1,1)&&a(1,4)&&a(2,1)&&a(2,4)&&a(3,2)&&a(3,3)&&a(3,4)&&a(4,1)&&a(4,4)&&a(4,5)&&a(5,1)&&a(5,5)&&a(6,1)&&a(6,4)&&a(6,5)&&a(7,2)&&a(7,3)?8:a(0,2)&&a(0,3)&&a(1,1)&&a(1,4)&&a(2,1)&&a(2,4)&&a(2,5)&&a(3,1)&&a(3,4)&&a(3,5)&&a(4,2)&&a(4,3)&&
a(4,4)&&a(4,5)&&a(5,5)&&a(6,1)&&a(6,4)&&a(7,2)&&a(7,3)?9:a(0,2)&&a(0,3)&&a(0,4)&&a(0,5)&&a(1,2)&&a(2,1)&&a(2,2)&&a(2,3)&&a(2,4)&&a(3,1)&&a(3,4)&&a(3,5)&&a(4,5)&&a(5,5)&&a(6,1)&&a(6,4)&&a(6,5)&&a(7,2)&&a(7,3)?5:a(0,4)&&a(1,3)&&a(1,4)&&a(2,2)&&a(2,3)&&a(2,4)&&a(3,2)&&a(3,4)&&a(4,1)&&a(4,4)&&a(5,0)&&a(5,1)&&a(5,2)&&a(5,3)&&a(5,4)&&a(5,5)&&a(6,4)&&a(7,4)?4:a(0,2)&&a(0,3)&&a(1,1)&&a(1,4)&&a(2,1)&&a(2,5)&&a(3,1)&&a(3,5)&&a(4,1)&&a(4,5)&&a(5,1)&&a(5,5)&&a(6,1)&&a(6,4)&&a(7,2)&&a(7,3)?0:a(0,3)&&a(1,2)&&a(1,
3)&&a(2,1)&&a(2,3)&&a(3,3)&&a(4,3)&&a(5,3)&&a(6,3)&&a(7,3)?1:a(0,2)&&a(0,3)&&a(0,4)&&a(1,1)&&a(1,4)&&a(1,5)&&a(2,5)&&a(3,4)&&a(4,3)&&a(4,4)&&a(5,2)&&a(6,1)&&a(6,2)&&a(7,1)&&a(7,2)&&a(7,3)&&a(7,4)&&a(7,5)?2:a(0,1)&&a(0,2)&&a(0,3)&&a(0,4)&&a(0,5)&&a(1,4)&&a(2,4)&&a(3,3)&&a(4,3)&&a(5,2)&&a(6,2)&&a(7,2)?7:3:a(0,3)&&a(0,4)&&a(1,5)&&a(3,1)&&a(3,3)&&a(4,1)&&a(7,4)?6:a(1,1)&&a(3,2)&&a(3,3)&&a(4,1)&&a(5,1)&&a(6,5)?8:a(1,1)&&a(2,1)&&a(4,2)&&a(4,3)&&a(4,5)&&a(6,4)?9:a(0,5)&&a(2,2)&&a(2,3)&&a(3,1)&&a(3,4)&&a(5,
5)&&a(7,2)?5:a(4,1)&&a(4,4)&&a(5,0)&&a(5,3)&&a(7,4)?4:a(2,5)&&a(4,1)&&a(5,1)&&a(5,5)&&a(6,1)?0:a(1,2)&&a(2,3)&&a(5,3)&&a(6,3)?1:a(1,5)&&a(5,2)&&a(6,2)&&a(7,4)&&a(7,5)?2:a(0,4)&&a(0,5)&&a(5,2)&&a(6,2)?7:3}function H(c,b){var a,e,d=0;e=c.width-4*Math.floor((b-1)/3);for(a=0;a<b;++a)e-=7,d+=Math.pow(10,a)*G(c,e),2==a%3&&(e-=3);return d}x(document.getElementById("leftBanners"));x(document.getElementById("playMenuButton"));
var I=parseInt(document.getElementById("playerInfoClintz").innerHTML.replace(" ","")),J=document.evaluate("//img[contains(@class,'character')]",document,null,6,null);for(i=0;i<J.snapshotLength;++i)x(J.snapshotItem(i));function L(){w&&(GM_setValue("isRunning",!0),location.reload())}
window.addEventListener("load",function(){var c=document.createElement("br"),b=document.createElement("hr"),a=document.createElement("div"),e=document.createElement("button"),d=document.createElement("button"),h=document.createElement("div");b.setAttribute("noshade","");b.setAttribute("color","#792829");e.setAttribute("type","button");e.setAttribute("class","urBtn small orange");e.setAttribute("style","margin:5px");var A,B;A=function(){GM_setValue("isRunning",!0);w=!0;L();e.innerHTML="STOP"};B=function(){e.addEventListener("click",
A,!1);GM_setValue("isRunning",!1);w=!1;e.innerHTML="START"};w?(e.addEventListener("click",B,!1),e.innerHTML="STOP"):(e.addEventListener("click",A,!1),e.innerHTML="START");d.setAttribute("type","button");d.setAttribute("class","urBtn small black");d.setAttribute("style","margin:5px");var y,C,p=document.createElement("button");p.setAttribute("type","button");p.setAttribute("class","urBtn small orange");p.setAttribute("style","margin:5px");p.innerHTML="Salva";p.addEventListener("click",function(){r=
document.getElementById("KS_reloadTime").value;k=document.getElementById("KS_riskBuy").value;t=document.getElementById("KS_imgDetectSafe").checked;v=document.getElementById("KS_sound").checked;u=document.getElementById("KS_autobuy").checked;GM_setValue("reloadTime",r);GM_setValue("riskValue",k);GM_setValue("imgDetectSafe",t);GM_setValue("sound",v);GM_setValue("autoBuy",u)},!1);y=function(){d.removeEventListener("click",y,!1);d.addEventListener("click",C,!1);h.setAttribute("class","marketClintzBox");
h.setAttribute("style","padding-left: 5px;margin: 5px");h.innerHTML="Velocit\u00e0 Aggiornamento: <select id='KS_reloadTime' class='filterSelect'><option value='0'>0 sec - Medio Alto rischio ban</option><option value='500'>0.5 sec - Medio rischio ban</option><option value='2000'>2 sec - Medio basso rischio ban</option><option value='5000'>5 sec - Basso rischio ban</option><option value='10000'>10 sec - Bassissimo rischio ban</option></select><br>Valori di acquisto e vendita: <select id='KS_riskBuy' class='filterSelect'><option value='0'>Parecchi acquisti - Rendimento Basso (4%), Alcune invendute [buy 0.9, sell 0.99]</option><option value='1'>Pochi acquisti - Rendimento Medio (9%), Alcune invendute [buy 0.85, sell 0.99]</option><option value='2'>Pochi acquisti - Rendimento Basso (5%), Poche invendute [buy 0.85, sell 0.95]</option><option value='3'>Pochissimi acquisti - Rendimento Alto (13%), Alcune invendute [buy 0.815, sell 0.99]</option><option value='4'>Pochissimi acquisti - Rendimento Medio (9%), Poche invendute [buy 0.815, sell 0.95]</option><option value='5'>Pochissimi acquisti - Rendimento Basso (4%), Pochissime invendute [buy 0.815, sell 0.9]</option></select><br><input id='KS_imgDetectSafe' type='checkbox' checked=true>  Riconoscimento Sicuro (lento)<br><input id='KS_sound' type='checkbox' checked=true>  Suono<br><input id='KS_autobuy' type='checkbox'>  Acquisto Automatico<br>";
h.appendChild(p);a.appendChild(c);a.appendChild(h);u&&(document.getElementById("KS_autobuy").checked=!0);v||(document.getElementById("KS_sound").checked=!1);t||(document.getElementById("KS_imgDetectSafe").checked=!1);document.getElementById("KS_riskBuy").querySelector("option[value='"+k+"']").selected="selected";document.getElementById("KS_reloadTime").querySelector("option[value='"+r+"']").selected="selected"};C=function(){d.removeEventListener("click",C,!1);d.addEventListener("click",y,!1);a.removeChild(c);
a.removeChild(h)};d.addEventListener("click",y,!1);d.innerHTML="CONFIG";a.appendChild(e);a.appendChild(d);var f=document.getElementById("contentPaddedContainerDiv");f.insertBefore(b,f.firstChild);f.insertBefore(a,f.firstChild);if(w){var g,z,q,M=document.evaluate("//div[@class='graph side1']",document,null,6,null),b=document.evaluate("//div[@class='marketRow']",document,null,6,null),K=document.evaluate("//div[contains(@id,'card')]/span[@class='boldText']/img",document,null,6,null);for(i=0;i<b.snapshotLength;++i)q=
M.snapshotItem(i).textContent.replace(/\s/g,"").match(/\d+/g),q=void 0!==q[2]?.1*parseInt(q[0])+parseInt(q[2]):500,g=D(K.snapshotItem(3*i)),z=E(g),F(g),f=H(g,z),g=D(K.snapshotItem(3*i+1)),z=E(g),F(g),g=H(g,z),convenient=g<=q&&(f/g<=l&&400>=f||f/g<=m),f>I||160<f&&!convenient?(f>I&&convenient&&(missed=!0,missedString+=b.snapshotItem(i).innerHTML.split('name">')[1].split("<")[0]+" "+f+"\n"),x(b.snapshotItem(i))):(125>=f&&(eval(document.evaluate(".//a[contains(@href,'javascript:buyCard')]",b.snapshotItem(i),
null,6,null).snapshotItem(0).href),x(b.snapshotItem(i))),document.evaluate("div[@class='content']",b.snapshotItem(i),null,6,null).snapshotItem(0).innerHTML+=Math.max(195,Math.round(g*n))+"<p>"+f+" - "+Math.round(1E4*f/g)/100+"% - Guadagno: "+Math.round(.95*Math.max(195,Math.round(g*n))-f)+"</p>");b=document.evaluate("//div[@class='marketRow']",document,null,6,null);if(0===b.snapshotLength)setTimeout(L,r);else if(u)for(i=0;i<b.snapshotLength;++i)f=(new DOMParser).parseFromString(b.snapshotItem(i).innerHTML,
"text/html"),unsafeWindow.eval(f.evaluate("//a[contains(@href,'javascript:buyCard')]",f,null,6,null).snapshotItem(0).href);b=new Audio("data:audio/wav;base64,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qJrx4KOQjahZxWbcZgztj2c49nKmkId44S71j0c8eV9yDK6uPRzx5X18eDvjvQ6yKo9ZSS6l//8elePK/Lf//IInrOF/FvDoADYAGBMGb7FtErm5MXMlmPAJQVgWta7Zx2go+8xJ0UiCb8LHHdftWyLJE0QIAIsI+UbXu67dZMjmgDGCGl1H+vpF4NSDckSIkk7Vd+sxEhBQMRU8j/12UIRhzSaUdQ+rQU5kGeFxm+hb1oh6pWWmv3uvmReDl0UnvtapVaIzo1jZbf/pD6ElLqSX+rUmOQNpJFa/r+sa4e/pBlAABoAAAAA3CUgShLdGIxsY7AUABPRrgCABdDuQ5GC7DqPQCgbbJUAoRSUj+NIEig0YfyWUho1VBBBA//uQZB4ABZx5zfMakeAAAAmwAAAAF5F3P0w9GtAAACfAAAAAwLhMDmAYWMgVEG1U0FIGCBgXBXAtfMH10000EEEEEECUBYln03TTTdNBDZopopYvrTTdNa325mImNg3TTPV9q3pmY0xoO6bv3r00y+IDGid/9aaaZTGMuj9mpu9Mpio1dXrr5HERTZSmqU36A3CumzN/9Robv/Xx4v9ijkSRSNLQhAWumap82WRSBUqXStV/YcS+XVLnSS+WLDroqArFkMEsAS+eWmrUzrO0oEmE40RlMZ5+ODIkAyKAGUwZ3mVKmcamcJnMW26MRPgUw6j+LkhyHGVGYjSUUKNpuJUQoOIAyDvEyG8S5yfK6dhZc0Tx1KI/gviKL6qvvFs1+bWtaz58uUNnryq6kt5RzOCkPWlVqVX2a/EEBUdU1KrXLf40GoiiFXK///qpoiDXrOgqDR38JB0bw7SoL+ZB9o1RCkQjQ2CBYZKd/+VJxZRRZlqSkKiws0WFxUyCwsKiMy7hUVFhIaCrNQsKkTIsLivwKKigsj8XYlwt/WKi2N4d//uQRCSAAjURNIHpMZBGYiaQPSYyAAABLAAAAAAAACWAAAAApUF/Mg+0aohSIRobBAsMlO//Kk4soosy1JSFRYWaLC4qZBYWFRGZdwqKiwkNBVmoWFSJkWFxX4FFRQWR+LsS4W/rFRb/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////VEFHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAU291bmRib3kuZGUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMjAwNGh0dHA6Ly93d3cuc291bmRib3kuZGUAAAAAAAAAACU=");
v&&b.play();B();missed&&alert(missedString)}},!1);
