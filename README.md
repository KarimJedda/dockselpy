## dockselfirchropy haha

Dockerfile example on how to *"assemble"* together Selenium (with support for both Chrome and Firefox), Python and Xfvb. For a similar setup, look for InstaPy on Github.

### Information

The image is build with the following dependencies:
- latest Chrome and chromedriver
- latest Firefox and geckodriver
- Selenium
- Python 3
- Xvfb and the python wrapper - pyvirtualdisplay


### Running:

- docker
    ```
    docker build -t selenium_docker .
    docker run --privileged -p 4000:4000 -d -it selenium_docker 
    ```
    
### Example

```python
from pyvirtualdisplay import Display
from selenium import webdriver

display = Display(visible=0, size=(800, 600))
display.start()

browser = webdriver.Firefox()
browser.get('https://www.google.com/')
print(browser.title)

browser.quit()
display.stop()

```

Detailed examples on how to use Firefox with custom profile and Google Chrome with desired options can be found in example.py.
