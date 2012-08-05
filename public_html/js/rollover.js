

(function(){
   var rolloverImages = [];
   
   function setRollOver2(){
     if(!document.images){return;}
     var imgs = document.images;
     var insert = [];
     for(var i=0,len=imgs.length; i<len; i++){
       var splitname = imgs[i].src.split('_rollout.');
       if(splitname[1]){
         var rolloverImg = document.createElement('img');
         rolloverImages.push(rolloverImg);
         rolloverImg.src = splitname[0]+'_rollover.'+splitname[1];
         var alpha = 0;
         rolloverImg.currentAlpha = alpha;
         rolloverImg.style.opacity = alpha/100;
         rolloverImg.style.filter = 'alpha(opacity='+alpha+')';
         rolloverImg.style.position = 'absolute';

         addEvent(rolloverImg,'mouseover',function(){setFader(this,100);});
         addEvent(rolloverImg,'mouseout',function(){setFader(this,0);});

         insert[insert.length] = {position:imgs[i],element:rolloverImg};
       }
     }

     for(i=0,len=insert.length; i<len ;i++){
       var parent = insert[i].position.parentNode;
       parent.insertBefore(insert[i].element,insert[i].position);
     }

     addEvent(window,'beforeunload', clearRollover);
   }


   function setFader(targetObj,targetAlpha){
     targetObj.targetAlpha = targetAlpha;
     if(targetObj.currentAlpha==undefined){
       targetObj.currentAlpha = 100;
     }
     if(targetObj.currentAlpha==targetObj.targetAlpha){
       return;
     }
     if(!targetObj.fading){
       if(!targetObj.fader){
         targetObj.fader = fader;
       }
       targetObj.fading = true;
       targetObj.fader();
     }
   }


   function fader(){
     this.currentAlpha += (this.targetAlpha - this.currentAlpha)*0.2;
     if(Math.abs(this.currentAlpha-this.targetAlpha)<1){
       this.currentAlpha = this.targetAlpha;
       this.fading = false;
     }
     var alpha = parseInt(this.currentAlpha);
     this.style.opacity = alpha/100;
     this.style.filter = 'alpha(opacity='+alpha+')';
     if(this.fading){
       var scope = this;
       setTimeout(function(){fader.apply(scope)},30);
     }
   }


   function clearRollover(){
     for(var i=0,len=rolloverImages.length; i<len; i++){
       var image = rolloverImages[i];
       image.style.opacity = 0;
       image.style.filter = 'alpha(opacity=0)';
     }
   }


   function addEvent(eventTarget, eventName, func){
     if(eventTarget.addEventListener){
       eventTarget.addEventListener(eventName, func, false);
     }else if(window.attachEvent){
       eventTarget.attachEvent('on'+eventName, function(){func.apply(eventTarget);});
     }
   }

   addEvent(window,'load',setRollOver2);

 })();
