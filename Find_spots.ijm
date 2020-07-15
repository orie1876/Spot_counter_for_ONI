
// Intensity algorithm 03.07.2006 //

// determines Center of Mass with batches (NB needs a Log directory made) //



run("Clear Results");

requires("1.33s"); 

   dir = getDirectory("Choose a Directory ");

   count = 0;

   countFiles(dir);

   n = 0;

   setBatchMode(true);

   processFiles(dir);

   //print(count+" files processed");

   

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

       if (endsWith(path, ".tif") || endsWith(path, ".tiff")) {

           open(path);



	

file= getTitle();				// image filename.tif 

root = substring(file,0,indexOf(file, ".tif"));		// image rootname



setBatchMode(true);

run("Z Project...", "start=1 stop="+nSlices+" projection=[Average Intensity]");

//run("Find Maxima...");

run("Find Maxima...", "noise=1000 output=Count");



//Count=getResult("Count");



//saveAs("Tiff", "+dir+"\\Log\\"+file+"_Ave.Tif");



close();



selectWindow(file);

close();





//selectWindow("Results");

//run("Text...", "save=);		// Save logged data as root.txt

//run("Close");



// ****************************************** //



} 	// End If loop	

}	// End batch processing loop