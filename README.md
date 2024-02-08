
<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/QHPC-SP-Research-Lab/Respiratory-Rate-Database/">
    <img src="./image/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Breath MY database</h3>

  <p align="center">
    An open-source audio database for respiratory rate (RR) estimation research
    <br />
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li><a href="#the-excel-file">Understanding the database structure</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#citing">Citing</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
<a name="about-the-project"></a>
## About The Project

Respiratory rate is a well-known acoustic biomarker of the health status of the respiratory system.
In this repository, we offer a systematic and labelled set of auditory recordings of 30 (15 male, 15 female) subjects, aged between 18 and 60 years-old, breathing at five different respiratory rates, organized by breaths per minute (bpm), captured with a conventional smartphone. As shown in Figure 1, during the recording sessions, subjects were positioned in front of the device at a distance of 20 and 40 cm.<br>
<img src="./image/figure1.jpg" alt="Figure1" style="width: 50%; height: 50%;">
Figure 1: placement of the subjects during the database recording process.


Each recording takes 1 minute, and was registered at 4500 Hz, one channel, 32-bit resolution.
Adsitional information about the health history of each subject is also provided, along with some other demographic data as heigh and weight.

The main objective of the "Respiratory Rate universities of Jaén and Oviedo" (RRuJO) dataset is to provide a set of reliably labeled sound signals at different respiratory rates so that they can be used by researchers to evaluate different algorithms applied to respiratory rate estimation from the analysis of sound respiratory signals.

The database is organized in folders according to the following structure:
<ul>
  <li>RRinervasO: recordings with the designed stethoscope (ESP32 based, Littman bell, INMP441 microphone)</li>
  <ul>
  <li>Folder named '8': recordings at 8 bpm</li>
  <li>Folder named '10': recordings at 10 bpm</li>
  <li>Folder named '12': recordings at 12 bpm</li>
  <li>Folder named '18': recordings at 18 bpm</li>
  <li>Folder named '20': recordings at 20 bpm</li>
</ul> 
  <li>ThinklabsO: recordings with the commercial <a href="https://www.thinklabs.com/">Thinklabs stethoscope</a></li>
  <ul>
  <li>Folder named '8': recordings at 8 bpm</li>
  <li>Folder named '10': recordings at 10 bpm</li>
  <li>Folder named '12': recordings at 12 bpm</li>
  <li>Folder named '18': recordings at 18 bpm</li>
  <li>Folder named '20': recordings at 20 bpm</li>
</ul> 
</ul> 

Inside each subfolder you will find 31 recordings following the CODE column of the <a href="https://github.com/QHPC-SP-Research-Lab/Respiratory-Rate-Database/blob/main/Metadata.md">Metadata.xlsx</a> file.

Example. This figure shows an example of the signal XXX.wav, belonging to the RRinervasO set, with a RR=10.

Figure 1

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- The excel file -->
<a name="the-excel-file"></a>
## Understanding the Excel file

The database is published along with an <a href="https://github.com/QHPC-SP-Research-Lab/Respiratory-Rate-Database/blob/main/Metadata.xlsx">Excel file</a> with the information about the subjects recorded. You can see this information in a friendly mode <a href="https://github.com/QHPC-SP-Research-Lab/Respiratory-Rate-Database/blob/main/Metadata.md">here</a>.
In that file, you will find the following fields:
 <ul>
  <li>Code: Temporal signature of the recording by the following format: year (four digits), month (two digits), day (two digits), hour (two digits), minutes (two digits) and the research group that captured the recording (University of Jaén=1, University of Oviedo=2). Thus, as an example, a participant auscultating at the University of Jaén on February 5, 2023 at 17:42 (format 24h) would obtain the following code: 2023020517421.</li>
  <li>Age (in years)</li>
  <li>Sex (M = Male, F = Female)</li>
  <li>Smoker? (0 = Non-smoker, 1 = Smoker)</li>
  <li>Heigh (in cm)</li>
  <li>Weight in Kg)</li>
  <li>Status? (0 = Healthy, 1 = Sick)</li>
  <li>Pathology: indicates what disease was the subject suffering from while being auscultated.</li>
</ul> 

<!-- LICENSE -->
<a name="license"></a>
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
<a name="contact"></a>
## Contact

José Ranilla Pastor, QHPC group - ranilla@uniovi.es

Group Link: [https://pirweb.edv.uniovi.es/] (QHPC Group)

Project Link: [https://github.com/QHPC-SP-Research-Lab/Respiratory-Rate-Database/](https://github.com/repo)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CITING -->
<a name="citing"></a>
## Citing
When using this dataset please cite the following publication “An orthogonal non-negative matrix factorization approach for respiratory rate estimation using a wireless stethoscope” as the source.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
<a name="acknowledgments"></a>
## Acknowledgments

This database has been supported in part under grant PID2020-119082RB-{C21,C22} funded by MCIN/AEI/10.13039/501100011033 of the Ministerio de Ciencia e Innovación de España, and grant
AYUD/2021/50994 funded by Gobierno del Principado de Asturias, Spain.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
