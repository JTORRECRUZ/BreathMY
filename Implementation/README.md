

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-database">About The Implementation</a>
    </li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#citing">Citing</a></li>
  </ol>
</details>



<!-- ABOUT THE DATABASE -->
<a name="about-the-implementation"></a>
## About The Implementation

This repository contains an implementation developed in MATLAB of the proposed method based on Non-Negative Matrix Partial Co-Factorization (NMPCF) to estimate the respiratory rate (RR) from sound signals.<br>

The implementation is structured as follows:

 <ul>
  <li> method.m: main script implementing the proposed method based on NMPCF to estimate RR from sound signals. It includes signal preprocessing, spectrogram conversion, iterative NMPCF, and finally, RR estimation.</li>
  <li> spectrogram.m: function responsible for computing the spectrogram of any input signal.</li>
  <li> training.m: function responsible for decomposing an input respiratory spectrogram using a blind non-negative matrix factorization (NMF) method. The output parameters obtained will be utilized in the NMPCF system.</li>
  <li> Dataset: reduced database containing respiratory signals from one of the participants, intended for testing the proposed implementation.</li>
  <li> Respiratory training signals: training respiratory signals ranging from 8 to 24 breaths per minute (bpm) from a random subject who has not participated in creating the BreathMY database. These signals are used in the "training" function.</li>
</ul> 

After executing the proposed method, an estimation of the RR is displayed in the command window.


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
<a name="license"></a>
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
<a name="contact"></a>
## Contact
Juan de la Torre Cruz (jtorre@ujaen.es)
<br>
Francisco Jesús Cañadas Quesada (fcanadas@ujaen.es)
<br>
Alejandro Antonio Salvador Navarro (aasn0001@red.ujaen.es)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CITING -->
<a name="citing"></a>
## Citing
When using this implementation please cite the following publication “Respiratory rate estimation applying non-negative matrix partial co-factorization from breath sounds, 22nd IEEE Mediterranean Electrotechnical Conference (MELECON), 2024”,  as the source.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
