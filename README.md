# ScanLiveText

## Background
My daughter who's second grader often asked me to check her math homework which
were column math sheets.It led me to think if it can be automated with IPhone 
camera. By the way I had no experience of iphone app development before.

## Goal
This app can extact the numbers and operators(+/-/*) from the worksheet and 
do the math and display the indicator whether they matches the results my 
daughter wrote down or not. 

## Implementation
After some research I did with Google, I decided to use Claude 3.5 to generate
the codebase, it used apple framework VisionKit for extracting text using iphone
camera, chatted back and forth with claude about the issues I had, and I got it
up and running on my iphone 14, so exiting! Then I started to tailor it to my 
specific needs, this was when my struggling with AI model came, it did not make 
some progress, I lost confidence to continue it with just aksing AI. I stepped
back to read the apple developer documents for VisonKit framework and Swift
language guide. and I regenerated the codebase with Claude, fixed several issues,
got the version of displaying the regonized text with green rectangle running.
The test result showed the OCR accuracy with VisionKit was NOT surfficient for
my original goal. So I stopped here. Furture, I'd try the OCR engine tesseract.

## Result
<!-- ![page_1](images/IMG_3698.jpg=1170×2532) -->
<img src="images/IMG_3698.jpg" width="30%" height="30%">
