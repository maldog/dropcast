dropcast
========

Powershell script for creating podcast rss feed from Dropbox public directory

Based on:
https://github.com/inoks/dropcast

1. Create dropbox account https://db.tt/NdkirSi
2. Download dropbox client https://www.dropbox.com/downloading
3. Enable public folder for your account https://www.dropbox.com/enable_public_folder
4. Put folders with mp3 in to Dropbox Public (or subfolder within)
5. Put Dropcast.ps1 anywhere on your computer
6. Right click on any file within the Public Folder and copy public link
7. Paste link to somethere and copy your id, ex, https://dl.dropbox.com/u/1234567/file.mp3 (1234567 in example)
8. Edit Dropcast.ps1 and change values in "# Config values" section
9. Run Dropcast.ps1 - it will create a podcast.rss file in the public folder
10. Copy public link to podcast.rss (Right click - Dropbox - Copy public link)
11. Enter link from clipboard to your podcast player
12. Enjoy!
