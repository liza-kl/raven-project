<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>


<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

-->


<br />
<div align="center">
  <a href="https://github.com/liza-kl/raven-project">
    <img src="https://cdn-icons-png.flaticon.com/512/5229/5229377.png" alt="Logo" width="120" height="120">
  </a>
<h3 align="center">RAVEN</h3>
 
  <p align="center">
    RAVEN is a framework to help you use Godot for creating visual environments. Currently available for Rascal.
    <br />
  <!--  <a href="https://github.com/liza-kl/raven-project"><strong>Explore the docs »</strong></a> 
    <br />
    <br />
 <a href="https://github.com/liza-kl/raven-project">View Demo</a>
    ·
    <a href="https://github.com/liza-kl/raven-project/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/liza-kl/raven-project/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a> -->
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com)-->

RAVEN is my Master's thesis project. It aims to connect the technological spaces of _language workbenches_
and _game engines_ in a _generic_ way. The goal is to have a prototype for creating visual programming environments with Godot. 

> [!WARNING]  
> This is a work in progress and has only been tested under macOS.


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!--### Built With
* [![Rascal][Rascal]][Next-url]
* [![Godot][Godot]][Next-url]
* [![Godot][Java]][Next-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- GETTING STARTED -->
## How to try it out

This is an example of how you may give instructions on setting up the project locally.


### Prerequisites

- You need at least Java Version 11 on your machine
- Please download the [0.9.1-4.2.2](https://github.com/utopia-rise/godot-kotlin-jvm/releases/tag/0.9.1-4.2.2) of the Godot/JVM framework
- If you are under macOS, please move the Godot Application to the Applications folder. 
- For "enhanced" developer experience, please consider [downloading](https://github.com/tmux/tmux/wiki) `tmux` 

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/liza-kl/raven-project.git
   ```
2. [Download Rascal](https://github.com/usethesource/rascal/releases/tag/v0.33.0)
3. In the `raven-example/raven-protocol` go to the `src/main&resources/config.yaml` and replace the `rascal-search-path`
   so it points to the `raven-project/raven-rascal-example/raven-core/src/main/rascal` project. 
4. Setup the project
   ```sh
   cd raven-core 
   make setup
   ```

If you have installed tmux: 

3. Run the Rascal example
   ```sh
   make run.rascal
   ```
4. See output via `tmux`:
   ```sh
   tmux -a -t raven-session 
   ```
5. To stop `tmux` session:
   ```sh
   make stop
   ```
If you have **not** installed `tmux`:

3. Start server
   ```sh
   make run.server
   ```
4. Start Godot.
   ```sh
   make run.godot
   ```

Now it should display the Tiny State Machine Example
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

_For an example with Rascal, please see [raven-rascal-example]([https://example.com](https://github.com/liza-kl/raven-project/tree/main/raven-rascal-example))_

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP 
## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature

See the [open issues](https://github.com/liza-kl/raven-project/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>-->



<!-- CONTRIBUTING 
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->


<!-- LICENSE -->
## License

Distributed under the BSD2 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>





<!-- ACKNOWLEDGMENTS 
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>-->



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/liza-kl/raven-project.svg?style=for-the-badge
[contributors-url]: https://github.com/liza-kl/raven-project/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/liza-kl/raven-project.svg?style=for-the-badge
[forks-url]: https://github.com/liza-kl/raven-project/network/members
[stars-shield]: https://img.shields.io/github/stars/liza-kl/raven-project.svg?style=for-the-badge
[stars-url]: https://github.com/liza-kl/raven-project/stargazers
[issues-shield]: https://img.shields.io/github/issues/liza-kl/raven-project.svg?style=for-the-badge
[issues-url]: https://github.com/liza-kl/raven-project/issues
[license-shield]: https://img.shields.io/github/license/liza-kl/raven-project.svg?style=for-the-badge
[license-url]: https://github.com/liza-kl/raven-project/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
