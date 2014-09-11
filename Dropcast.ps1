#Dropcast for Powershell
#Creates a 'podcast.rss' file from a list of mp3/m4a files
#URLs based on Dropbox public folders
#Based on Python dropcast @ https://github.com/inoks/dropcast

# Config values
$Dropbox_ID = "123456";
$podcast_title = "My Podcast";
$podcast_description = "This podcast created in dropcast";
#The following url_base assumes the mp3/m4a files will be in the root of your public folder
#Feel free to place your files within a sub-folder, ex. https://.../u/{0}/MyPodcast
$public_url_base = ('https://dl.dropboxusercontent.com/u/{0}/' -f $Dropbox_ID);
#Local Folder Path
#Again, feel free to use a sub-folder if desired, ex. ...\Dropbox\Public\MyPodcast
$podcast_folder = 'C:\Users\...\Dropbox\Public\';

# Generated values
$date_format = 'ddd, dd MMM yyyy HH:mm:ss EST';
$podcast_pub_date = (Get-Date -Format $date_format);

# Build the items
$items_content = "";
[System.IO.FileInfo] $AudioFile;

$AudioFiles = Get-ChildItem ('{0}\*' -f $podcast_folder) -Include *.mp3, *.m4a;
foreach ($AudioFile in $AudioFiles)
{
	$item_size_in_bytes = $AudioFile.Length;
	$item_pub_date = (Get-Date $AudioFile.LastWriteTime -Format $date_format);
	$item_title = $AudioFile.BaseName;
	$item_subtitle = "";
	$item_summary = $item_subtitle;
	$item_url = ("{0}/{1}" -f $public_url_base, $AudioFile.Name);
$item_content = @"
<item>
	<title>$item_title</title>
	<itunes:subtitle>$item_subtitle</itunes:subtitle>
	<itunes:summary>$item_summary</itunes:summary>
	<enclosure url="$item_url" length="$item_size_in_bytes" type="audio/mpeg" />
	<pubDate>$item_pub_date</pubDate>
</item>

"@
	$items_content += $item_content;
}

# Build the whole file
$content = @"
<?xml version="1.0" encoding="ISO-8859-1"?>
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
<channel>
<title>$podcast_title</title>
<description>$podcast_description</description>
<pubDate>$podcast_pub_date</pubDate>
$items_content
</channel>
</rss>
"@

$content | Out-File -FilePath ('{0}\podcast.rss' -f $podcast_folder) -Force;
