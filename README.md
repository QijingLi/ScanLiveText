# ScanLiveText

## Background
My sweet daughter(a second grader) often asked me to check her math homework.
That made me think If I can develop an app to autocheck using iphone's camera.

## Goal
This app can extact the only numbers and operators(+/-/*) from the column math
sheets and do the math and then display the indicator which are correct and
which are not. 

## Implementation
I had no experience of iphone app development. After some research I did with
Google, I decided to use Claude 3.5 to generate the codebase which used apple's
framework VisionKit, after chatted back and forth with claude, and I got it up
and running on my iphone 14, so exiting! Then I started to tailor it to my
specific needs by asking Claude to make changes, but I always got build errors.
I could not make any progress for a while. And I stepped back to read the apple
developer documents and played around Swift language. And I regenerated the
codebase with Claude, fixed several issues, this time I was confident to make
changes, I know what I was doing. I got this iteration working which was to
simply display the regonized text with green rectangle, I just wanted to see
the OCR accuracy is good enough, unfortunately it's not, so I stopped here. 
Furture, I'd probably try the OCR engine tesseract.

## Result
<!-- ![page_1](images/IMG_3698.jpg=1170×2532) -->
<img src="images/IMG_3698.jpg" width="30%" height="30%">
