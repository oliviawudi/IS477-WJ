# Reproducing This Project
This document describes how to reproduce the full analysis pipeline for the IS 477 final project on financial literacy, credit card debt, and post-COVID household behavior using Federal Reserve SHED and CFPB data.
The goal is that someone with access to the data and this repository can regenerate all cleaned data, analysis outputs, and visualizations.

# Pre-req
You will have to be running our scripts:
- git
- python >= 3.10
- pip
- snakemake
- A unix-like shell

# Set up the Python Enviroment
- Create and acticate a virtual enviroment
- Install dependencies, also in box as requirements.txt, you can directly do "pip install -r requirements.txt"
  1)pandas
  2)numpy
  3)matplotlib
  4)seaborn
  5)pyreadstat
  6)snakemake
  7)scikit-learn
  8)pyarrow
- Install Snakemake

# Full Enviroment Snapshot
- In box as pip-freeze.txt
- appdirs==1.4.4
appnope==0.1.4
asttokens==3.0.0
attrs==25.1.0
beautifulsoup4==4.13.1
bs4==0.0.2
certifi==2024.8.30
cffi==1.17.1
charset-normalizer==3.4.1
click==8.3.0
comm==0.2.2
contourpy==1.3.1
cryptography==44.0.2
cssselect==1.2.0
cycler==0.12.1
debugpy==1.8.9
decorator==5.1.1
docutils==0.21.2
et_xmlfile==2.0.0
executing==2.1.0
fake-useragent==2.0.3
filelock==3.20.0
fonttools==4.55.2
fsspec==2025.12.0
h11==0.14.0
idna==3.10
importlib_metadata==8.6.1
ipykernel==6.29.5
ipython==8.30.0
ipywidgets==8.1.5
jaraco.classes==3.4.0
jaraco.context==6.0.1
jaraco.functools==4.1.0
jedi==0.19.2
Jinja2==3.1.6
joblib==1.4.2
jupyter_client==8.6.3
jupyter_core==5.7.2
jupyterlab_widgets==3.0.13
keyring==25.6.0
kiwisolver==1.4.7
lxml==5.3.0
markdown-it-py==3.0.0
MarkupSafe==3.0.3
matplot==0.1.9
matplotlib==3.9.3
matplotlib-inline==0.1.7
mdurl==0.1.2
more-itertools==10.5.0
mpmath==1.3.0
narwhals==2.13.0
nest-asyncio==1.6.0
networkx==3.6.1
nh3==0.2.20
nltk==3.9.2
numpy==2.1.3
openpyxl==3.1.5
outcome==1.3.0.post0
packaging==24.2
pandas==2.2.3
parse==1.20.2
parso==0.8.4
patsy==1.0.1
pdf2image==1.17.0
pdfminer==20191125
pdfminer.six==20250327
pexpect==4.9.0
pillow==11.0.0
pkginfo==1.12.0
platformdirs==4.3.6
prompt_toolkit==3.0.48
psutil==6.1.0
ptyprocess==0.7.0
pure_eval==0.2.3
pycparser==2.22
pycryptodome==3.22.0
pyee==11.1.1
Pygments==2.18.0
pyloco==0.0.139
PyMuPDF==1.25.5
pyparsing==3.2.0
PyPDF2==3.0.1
pyppeteer==2.0.0
pyquery==2.0.1
pyreadstat==1.3.2
PySocks==1.7.1
pytesseract==0.3.13
python-dateutil==2.9.0.post0
python-dotenv==1.0.1
pytz==2024.2
pyzmq==26.2.0
readme_renderer==44.0
regex==2025.9.18
requests==2.32.3
requests-html==0.10.0
requests-toolbelt==1.0.0
rfc3986==2.0.0
rich==13.9.4
scikit-learn==1.5.2
scipy==1.14.1
seaborn==0.13.2
selenium==4.28.1
setuptools==75.8.0
SimpleWebSocketServer==0.1.2
six==1.17.0
sniffio==1.3.1
sortedcontainers==2.4.0
soupsieve==2.6
stack-data==0.6.3
statsmodels==0.14.4
sympy==1.14.0
threadpoolctl==3.5.0
torch==2.9.1
torchaudio==2.9.1
torchvision==0.24.1
tornado==6.4.2
tqdm==4.67.1
traitlets==5.14.3
trio==0.28.0
trio-websocket==0.11.1
twine==6.0.1
typing==3.7.4.3
typing_extensions==4.12.2
tzdata==2024.2
undetected-chromedriver==3.5.5
urllib3==1.26.20
ushlex==0.99.1
w3lib==2.3.1
wcwidth==0.2.13
webdriver-manager==4.0.2
websocket-client==1.8.0
websockets==10.4
widgetsnbextension==4.0.13
wsproto==1.2.0
zipp==3.21.0

# Obtain the data 
- The SHED data are public-use but cannot be redistributed via this repository. You must download them directly from the Federal Reserve:
1. Link to Federal Reserve SHED data portal: https://www.federalreserve.gov/consumerscommunities/shed.htm
2. Download the following files: a) 2020 SHED microdata (CSV) b) 2024 SHED microdata (sas7bdat)
3. Save them to /data/shed/.
- CFPB data is publically licensed;raw files are included directly in box.

# License
- Our code is released under the MIT license, allowing reuse with attribution.
- SHED: cannot be redistrubuted; terms of use provided with the link.
- CFPB: publically licensed government data.
