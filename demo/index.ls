
ldcv = new ldCover {root: document.querySelector('.ldcv')}
ldcv.toggle false

show = -> ldcv.get!then -> console.log \ok, it
