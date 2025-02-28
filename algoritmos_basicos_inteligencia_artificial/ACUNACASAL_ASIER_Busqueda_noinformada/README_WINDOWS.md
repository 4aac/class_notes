# Algoritmos Básicos de la Inteligencia Artificial

## Introducción

<div style="text-align: justify">
La realización de las prácticas correspondientes a esta asignatura se llevará a cabo utilizando Python acompañado del uso de distintas librerías:

* **[aima-python](https://github.com/aimacode/aima-python)**, código en python del libro "Artificial Intelligence A Modern Approach", utilizado como bibliografía básica de la asignatura. 
* **[PyCSP3](http://pycsp.org/)**
* **[Matplotlib]()**


## Configuración del entorno de prácticas

Para facilitar la interacción con python, las librerías y la entrega de resultados, las prácticas se harán sobre **[Jupyter Notebooks](https://jupyter.readthedocs.io/en/latest/index.html)**. Para minimizar las diferencias entre entornos y posibles dificultades de configuración (pues nos interesa que los resultados sean repetibles y facilitar la realización de las prácticas), los Notebooks se ejecutarán mediante **[Contenedores Docker](https://www.docker.com/)**. De esta forma, es necesario que tengáis **[Docker instalado](https://docs.docker.com/desktop/windows/install/)** en vuestros equipos (**esto sólo hay que hacerlo una vez**):

* Descargamos **[Docker Desktop Installer.exe](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe)**
* Ejecutamos `Docker Desktop Installer.exe` (Dejar marcado "*Install required Windows components for WSL 2*" o "*Enable Hyper-V Windows Features*") 
* Seguir las instrucciones del wizard y al final seleccionar "*Cerrar y reiniciar*" 
* Al encender el ordenador de nuevo, aparecerá un cartel de "*Our Service Agreement has Changed*". Hay que **aceptar** los términos y proceder. 
* Si aparece un error de "*WSL 2 installation is incomplete*", **sin cerrar la ventana**, dirigirse al enlace que proporciona (**[https://aka.ms/wsl2kernel](https://aka.ms/wsl2kernel)**), descargar `wsl_update_x64.msi` (ó `wsl_update_arm64.msi` si se usa ARM64), ejecutarlo y seguir las instrucciones. Tras esto, presionar "*Restart*" en la ventana "*WSL 2 installation is incomplete*". 
* Se nos abrirá una ventana con el texto "*Docker Engine Starting...*". Esperamos hasta que aparezca "*Get started with Docker in a few easy steps!*". y pulsamos sobre "*Skip tutorial*". 
* La ventana pasará a tener "*No containers running*". Ya tenemos Docker instalado y estamos listos para usarlo. Podemos minimizar la ventana de *Docker Desktop*.


**Creación de la imagen** (`build`)

Crearemos la imagen descrita en el fichero `Dockerfile`. Para ello, primeramente debemos descargar y descomprimir los ficheros que encontrarás en el Campus Virtual. Una vez hecho esto, abrimos la carpeta contenedora, pulsamos `Shift + Click derecho` en la misma y seleccionamos "*Abrir la ventana de PowerShell aquí*". En la terminal escribimos (**esto sólo hay que hacerlo una vez**):
```shell
docker build -t gria-abia2425 .
```
Si aparece una alerta del *Firewall de Windows*, debemos permitir que Docker Desktop Backend se comunique con las redes. Cuando finalice el comando (le llevará un rato, pues tiene que descargar algunas cosas), ya tendremos la imagen creada. 


**Ejecución del contenedor** (`run`)

El contenedor que utilizaremos empleará como base la imagen anteriormente descrita. Abriremos la carpeta con los boletines de prácticas, pulsaremos `Shift + Click derecho` en la misma y seleccionaremos "*Abrir la ventana de PowerShell aquí*". En la terminal escribimos (**esto habrá que hacerlo cada vez que queramos trabajar**):
```shell
docker run -it --rm --name="AIBA" -v "${PWD}:/home/jovyan/work" -p 8888:8888 gria-abia2425 start-notebook.sh --ServerApp.token=''
```
Puede que aparezca una alerta de "*Docker Desktop - Filesharing*", pero podemos ignorarla.

Una vez ejecutado el comando, podremos entrar al servidor de Jupyter Notebook a través de un navegador, en la dirección **[http://127.0.0.1:8888](http://127.0.0.1:8888)**.
Finalmente, para cerrar el contenedor (**asegúrate antes de haber guardado los cambios en los Notebooks**) pulsaremos `Control-C` en la terminal en la que ejecutamos el comando.

</div>


