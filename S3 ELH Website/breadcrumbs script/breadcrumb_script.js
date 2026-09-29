var crumbsep = " > "; // Separator between each folder
var precrumb = "<span class=\"crumb\">"; //sets up the breadcrumb class
var postcrumb = "</span>"; // closes out the breadcrumb class
var sectionsep = "/"; // slash between URLs
var rootpath = "/"; // "/" indicates the root of domain - ensures the home bucket name remains intact
var rootname = "Home"; // Name of the home bucket in the directory

var ucfirst = 1; // if set to 1, makes "directory" default to "Directory"

var objurl = new Object;

// This section of the code takes the page's url and breaks it up into directory pieces
var pageurl = (new String(document.location)); // the page's URL
var protocol = pageurl.substring(0, pageurl.indexOf("//") + 2); // finds the protocol...
pageurl = pageurl.replace(protocol, ""); // ...and separates the protocol from pageurl
var rooturl = pageurl.substring(0, pageurl.indexOf(rootpath) + rootpath.length); // find rooturl
if (rooturl.charAt(rooturl.length - 1) == "/") //remove trailing slash
{
  rooturl = rooturl.substring(0, rooturl.length - 1);
}
pageurl = pageurl.replace(rooturl, ""); // remove rooturl from pageurl
if (pageurl.charAt(0) == '/') // remove beginning slash
{
  pageurl = pageurl.substring(1, pageurl.length);
}

var page_ar = pageurl.split(sectionsep);
var currenturl = protocol + rooturl;
var allbread = precrumb + "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/legislative-history-index.html" + "\">" + rootname + "</a>";  + postcrumb //sets up "Home" option to link to index page

//for every folder/chunk of the page's URL...
for (i=0; i < page_ar.length-1; i++)
{
  var displayname = ""; // sets up the display name for the bucket/folder, instead of our long ungraceful bucket names :)
  currenturl += "/" + page_ar[i];
  if (objurl[page_ar[i]])
  {
    displayname = objurl[page_ar[i]];
  }
  else
  {
    if (ucfirst == 1)
    {
      displayname = page_ar[i].charAt(0) + page_ar[i].substring(1);
    }
    else
    {
      displayname = page_ar[i];
    }
  }
  //This will switch the displayname and associated URL based on the folder/bucket name
  //Edit the below as we add new buckets and folders to the LegH website.
  //To do so:
  switch (displayname){
	  case "https://ustc-elh-static-website.s3.amazonaws.com":
		  displayname = "Home";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/legislative-history-index.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "103rd+congress":
		  displayname = "103rd Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/103rd+congress/103rd+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "104th+congress":
		  displayname = "104th Congress";
		  currenturl = `<a href=\"https://ustc-elh-static-website.s3.us-east-1.amazonaws.com/104th+congress/104th+congress.html\">${displayname}</a>`; 
		  break;
	  case "105th+congress":
		  displayname = "105th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/105th+congress/105th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "106th+congress":
		  displayname = "106th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/106th+congress/106th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	case "107th+congress":
		  displayname = "107th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/107th+congress/107th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "108th+congress":
		  displayname = "108th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/108th+congress/108th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "109th+congress":
		  displayname = "109th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/109th+congress/109th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
      case "110th+congress":
		  displayname = "110th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/110th+congress/110th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "111th+congress":
	      displayname = "111th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/111th+congress/111th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "112th+congress":
	      displayname = "112th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/112th+congress/112th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "115th+congress":
	      displayname = "115th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/115th+congress/115th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "116th+congress":
	      displayname = "116th Congress";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/116th+congress/116th+congress.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "pl+110-245":
		  displayname = "PL 110-245";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/110th+congress/pl+110-245/pl+110-245.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "pl+111-366":
	      displayname = "PL 111-366";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/111th+congress/pl+111-366/pl+111-366.html" + "\">" + displayname + "</a>"; 
		  break;
	  case "pl+112-56":
	      displayname = "PL 112-56";
		  currenturl = "<a href=\"https://ustc-elh-static-website.s3.amazonaws.com/112th+congress/pl+112-56/pl+112-56+index.html" + "\">" + displayname + "</a>"; 
		  break;
      default: 
		  displayname = "Placeholder";
 } 
  
  allbread += crumbsep + precrumb + currenturl + postcrumb;
}
document.write(allbread);