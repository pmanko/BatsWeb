function download_files(files) {
    function download_next(i) {
        if (i >= files.length) {
            return;
        }
        var xhr = new XMLHttpRequest(),
          a = document.createElement('a'), file;
        //console.log(i);
        //console.log(files.length);
 //       if (i == 0) {
    //        console.log('start');
    //    }
       // if (i == files.length - 1) {
         //   console.log('add');
        //percentDownload.push(0);
       // xhr.onprogress = updateProgress;
        //xhr.onload = updateTotal;
        //  }
        //new
        //xhr.open("HEAD", files[i].download, true); // Notice "HEAD" instead of "GET",
        ////  to get only the header
        //xhr.onreadystatechange = function () {
        //    if (this.readyState == this.DONE) {
        //        callback(parseInt(xhr.getResponseHeader("Content-Length")));
        //    }
        //};
        //
        if (i > 0) {
            if (files[i].download.substring(files[i].download.lastIndexOf('/')) != files[i - 1].download.substring(files[i - 1].download.lastIndexOf('/'))) {
                cutTimes += files[i].filename + "@";
                clipsNames.push(Math.floor(Date.now() / 1000) + i + '.mp4');
                cutTimes += (clipsNames[i] + ':' + videoPaths[i].substring(videoPaths[i].lastIndexOf("=") + 1, videoPaths[i].length).replace(",", ";")) + ',';
            }
            else {
                cutTimes += files[i].filename + "@";
                clipsNames.push(Math.floor(Date.now() / 1000) + i + '.mp4');
                cutTimes += (clipsNames[i - 1] + ':' + videoPaths[i].substring(videoPaths[i].lastIndexOf("=") + 1, videoPaths[i].length).replace(",", ";")) + ',';
            }
        }
        else {
            cutTimes += files[i].filename + "@";
            clipsNames.push(Math.floor(Date.now() / 1000) + i + '.mp4');
            cutTimes += (clipsNames[i] + ':' + videoPaths[i].substring(videoPaths[i].lastIndexOf("=") + 1, videoPaths[i].length).replace(",", ";")) + ',';
        }
        percentDownload.push(0);
        xhr.onprogress = function (evt) {
            if (evt.lengthComputable) {  // evt.loaded the bytes the browser received
                var percentComplete = (evt.loaded / evt.total) * 100;
                percentDownload[i] = percentComplete;
                totalComplete = 0;
                for (var j = 0; j < percentDownload.length; j++)
                    totalComplete += percentDownload[j];
                //percentDownload[i] = evt.loaded;
                //console.log(totalComplete / (files.length * 100));
                bar.style.width = (totalComplete / (files.length)).toFixed(2) + '%';
                bar.innerText = (totalComplete / (files.length)).toFixed(2) + '%';
                //if ((totalComplete / (files.length)) == 100) {
                //    document.getElementById("btnDownload").innerHTML = "Download Comlete!";
                //    document.getElementById("btnDownload").disabled = false;
                //    var a = window.document.createElement('a');
                //    console.log(cutTimes);
                //    a.href = window.URL.createObjectURL(new Blob([cutTimes], { type: 'text/csv' }));
                //    a.download = 'cut.txt';

                //    // Append anchor to body.
                //    document.body.appendChild(a);
                //    a.click();

                //    // Remove anchor from body
                //    document.body.removeChild(a);
                //    console.log(cutTimes);
                //}
            }
        }
          xhr.open('GET', files[i].download, true);
          xhr.responseType = 'blob';
          xhr.onload = function () {
              file = new Blob([xhr.response], { type : 'application/octet-stream' });
              a.href = window.URL.createObjectURL(file);
              //console.log(clipsNames[i]);
              a.download = clipsNames[i];  // Set to whatever file name you want
              //a.download = Math.floor(Date.now() / 1000) + i + '.mp4';  // Set to whatever file name you want
             // console.log(files[i].download.substring(files[i].download.lastIndexOf('/')));
              //console.log(xhr.response.size);
              //totalDownload += xhr.response.size;
              // Now just click the link you created
              // Note that you may have to append the a element to the body somewhere
              // for this to work in Firefox
              a.target = '_parent';
              (document.body || document.documentElement).appendChild(a);
              if (i > 0) {
                  if (files[i].download.substring(files[i].download.lastIndexOf('/')) != files[i - 1].download.substring(files[i - 1].download.lastIndexOf('/'))) {
                      if (a.click) {
                          a.click(); // The click method is supported by most browsers.
                      } else {
                          $(a).click(); // Backup using jquery
                      }
                  }
              }
              else {
                  if (a.click) {
                      a.click(); // The click method is supported by most browsers.
                  } else {
                      $(a).click(); // Backup using jquery
                  }
              }
              a.parentNode.removeChild(a);
              clipsDone++;
              //console.log(clipsDone);
              //console.log(files.length);
              //console.log(totalComplete);
              if (clipsDone / files.length == 1) {
                  bar.style.width = (100).toFixed(2) + '%';
                  bar.innerText = (100).toFixed(2) + '%';
                  document.getElementById("btnDownload").innerHTML = "Download Complete!";
                  document.getElementById("btnDownload").disabled = false;
                  var b = window.document.createElement('a');
                  //console.log(cutTimes);
                  b.href = window.URL.createObjectURL(new Blob([cutTimes], { type: 'text/csv' }));
                  b.download = 'cut.txt';
                  // Append anchor to body.
                  document.body.appendChild(b);
                  b.click();
                  // Remove anchor from body
                  document.body.removeChild(b);
              }
          };
          xhr.send();
        //var a = document.createElement('a');
        //a.href = files[i].download;
       // a.target = '_parent';
        // Use a.download if available, it prevents plugins from opening.
       // if ('download' in a) {
       //     a.download = files[i].filename;
       // }
        // Add a to the doc for click to work.
       // (document.body || document.documentElement).appendChild(a);
       // if (a.click) {
      //      a.click(); // The click method is supported by most browsers.
       // } else {
       //     $(a).click(); // Backup using jquery
       // }
        // Delete the temporary link.
       // a.parentNode.removeChild(a);
        // Download the next file with a small timeout. The timeout is necessary
        // for IE, which will otherwise only download the first file.
        setTimeout(function () {
            download_next(i + 1);
        }, 500);
    }
    // Initiate the first download.
    //var totalDownload = 0;
    var bar = document.getElementById('theBar');
    var totalComplete = 0;
    var clipsDone = 0;
    var cutTimes = "";
    var percentDownload = [];
    var clipsNames = [];
    download_next(0);
}
