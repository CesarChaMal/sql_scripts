function gettext(elem){return elem.innerText || elem.textContent;}
function getcode(elem){
var ols=elem.getElementsByTagName('ol');
var lis=ols[0].getElementsByTagName('li');
var code='';
for(var i=0,l=lis.length;i<l;i++){
code+=gettext(lis[i]); 
if(navigator.userAgent.indexOf('Safari')==-1)code += "\n";
}
return code;
}
function copiar(obj){
obj=obj.nextSibling;
var code=getcode(obj);
if (window.clipboardData){
window.clipboardData.setData("text", code);
obj.oncopy=function(){return false;}
}else{
var swfpath='http://static.forosdelweb.com/clientscript/clipboard.swf';
flashcopier=document.createElement('div');
obj.appendChild(flashcopier);
flashcopier.innerHTML = '<embed src="' + swfpath + '" FlashVars="clipboard='+encodeURIComponent(code)+'" width="0" height="0" type="application/x-shockwave-flash"></embed>';
}
alert('El código fue copiado.');
}
function veroriginal(obj){
obj=obj.nextSibling;
obj=obj.nextSibling;
var code=getcode(obj);
var wnd = window.open('', '_blank', 'width=750, height=400, location=0, resizable=1, menubar=0, scrollbars=0');
code = code.replace(/&/g,'&amp;');
code = code.replace(/</g,'&lt;');
code = code.replace(/>/g,'&gt;');
wnd.document.write('<textarea rows="29" style="width:99%;height:99%">' + code + '</textarea>');
wnd.document.close();
}
