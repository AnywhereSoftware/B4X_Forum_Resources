### ANPR with YOLOv8 + OCR (B4A) – rectangles OK, OCR optimized by roberto64
### 02/05/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170226/)

Hi everyone,  
I'm working on an ANPR (license plate recognition) project in B4A using:  
CamEx2 for the camera  
YOLOv8 (TensorFlow Lite) via a custom Java wrapper  
ML Kit TextRecognizer (Latin) for OCR  
Currently:  
✔️ License plate detection is working correctly  
✔️ The red rectangle is aligned with the preview  
✔️ The license plate is cropped correctly  
✔️ I've implemented simple tracking to avoid continuous OCR  
I've optimized the OCR so that it only runs when the license plate is stable for a few frames, to improve performance and reduce latency.  
The link is below.  
[MEDIA=googledrive]1EGSAeBIm1W9sr9iANo\_zZMeGoQzFQZjf[/MEDIA], [MEDIA=googledrive]1SBuKgjE0m8JOuel8q1YJnP-otYkh\_Uaa[/MEDIA], [MEDIA=googledrive]1XSVKDjTUusoxOrTQu\_-7UWwYX0sPvzE-[/MEDIA], [MEDIA=googledrive]1\_I2J4vubXjjKJa9ru9cv6IDz0jjiX3NU[/MEDIA], [MEDIA=googledrive]1sShQP503fGP2MbrhAlM\_YbajCt0BpPQh[/MEDIA]