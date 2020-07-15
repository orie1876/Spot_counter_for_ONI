end_of_filename="channels_t0_posZ0.tif" 	// Change to suit the filename that needs selecting. 
noise_threshold="10"		// Noise threshold - check with find maxima in IJ first. 
side="right"			// For "left" or "right" side of the image. 



run("Clear Results");

requires("1.33s"); 

   dir = getDirectory("Choose root Directory ");

   count = 0;

   countFiles(dir);

   n = 0;

   setBatchMode(true);

   processFiles(dir);


   

   function countFiles(dir) {

      list = getFileList(dir);

      for (i=0; i<list.length; i++) {

  if (!startsWith(list[i],"Log")){

        if (endsWith(list[i], "/"))

              countFiles(""+dir+list[i]);

          else

              count++;

      }

  }

}

   function processFiles(dir) {

      list = getFileList(dir);

      for (i=0; i<list.length; i++) {

if (!startsWith(list[i],"Log")){

          if (endsWith(list[i], "/"))

              processFiles(""+dir+list[i]);

          else {

             showProgress(n++, count);

             path = dir+list[i];

             processFile(path);

          }

}

      }

  }



  function processFile(path) {

       if (endsWith(path, end_of_filename)) {

           open(path);



	

file= getTitle();				// image filename.tif 

root = substring(file,0,indexOf(file, ".tif"));		// image rootname



setBatchMode(true);

run("Z Project...", "start=1 stop="+nSlices+" projection=[Average Intensity]");

if(side=="left"){
makeRectangle(0, 0, 428, 684);
}
else if(side=="right"){
makeRectangle(428, 0, 856, 684);
}
run("Crop");

run("Find Maxima...", "noise="+noise_threshold+" output=Count");



//Count=getResult("Count");



saveAs("Tiff", ""+dir+file+"_Ave.tif");



close();



selectWindow(file);

close();








} 	// End If loop	

}	// End batch processing loop