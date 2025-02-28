# Algoritmos Básicos de la Inteligencia Artificial

## Introducción

<div style="text-align: justify">
La realización de las prácticas correspondientes a esta asignatura se llevará a cabo utilizando Python acompañado del uso de distintas librerías:

* **[aima-python](https://github.com/aimacode/aima-python)**, código en python del libro Artificial Intelligence A Modern Approach, utilizado como bibliografía básica de la asignatura. 
* **[PyCSP3](http://pycsp.org/)**
* **[Matplotlib]()**

## Configuración del entorno de prácticas

Para facilitar la interacción con python, las librerías y la entrega de resultados, las prácticas se harán sobre **[Jupyter Notebooks](https://jupyter.readthedocs.io/en/latest/index.html)**. Para minimizar las diferencias entre entornos y posibles dificultades de configuración (pues nos interesa que los resultados sean repetibles y facilitar la realización de las prácticas), los Notebooks se ejecutarán mediante **[Contenedores Docker](https://www.docker.com/)**. De esta forma, es necesario que tengáis **[Docker instalado](https://docs.docker.com/get-docker/)** en vuestros equipos. Para los usuarios de Linux, es importante seguir los pasos del **[docker post-install](https://docs.docker.com/engine/install/linux-postinstall/)** para finalizar la configuración.

**Creación de la imagen** (`build_image.sh`)

Crearemos una imagen que usará como base `quay.io/jupyter/scipy-notebook:python-3.11` (sería bueno descargarla cuanto antes mediante: `docker pull quay.io/jupyter/scipy-notebook:python-3.11`). A esta le añadiremos una serie de dependencias, descritas en el fichero `Dockerfile`. La creación de la imagen en Linux (o WSL) se realiza con el siguiente comando (incluido en `build_image.sh`):
```
docker build -t gria-abia2425 .
```

**Ejecución del contenedor** (`run_container.sh`)

El contenedor que utilizaremos empleará como base la imagen anteriormente descrita. Al ejecutar el contenedor, le indicaremos que mapee el puerto del servidor de Jupyter Notebook (puerto `8888`) a un puerto de nuestro ordenador (el `8888`, por ejemplo). También le indicaremos que monte nuestro directorio actual (`${PWD}`) en vez del directorio work del contenedor (`/home/jovyan/work`), de esta manera el servidor podrá ver nuestros archivos y editarlos sin ningún problema. Para solucionar posibles problemas de permisos, le indicamos al contenedor que el usuario tenga el mismo GID y UID que el de nuestro PC (`--user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) -e CHOWN_HOME=yes -e CHOWN_HOME_OPTS='-R'`). Adicionalmente, haremos que no sea necesario autenticarnos a la hora de conectarnos al servidor (`--NotebookApp.token=''`), para evitar posibles problemas con tokens y sesiones. Por último, nos va a interesar ejecutar el contenedor interactivamente (`-it`) y que este se elimine una vez cerrado (`--rm`), para minimizar conflictos. Todo esto en Linux se realizaría con el siguiente comando (incluido en `run_container.sh`):
```
docker run --user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) \
-e CHOWN_HOME=yes -e CHOWN_HOME_OPTS='-R' -it --rm --name="AIBA" \
-v "${PWD}":/home/jovyan/work -p 8888:8888 gria-abia2425 start-notebook.sh --ServerApp.token=''

docker run --user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) -e CHOWN_HOME=yes -e CHOWN_HOME_OPTS='-R' -it --rm --name="AIBA" -v "${PWD}":/home/jovyan/work -p 8888:8888 gria-abia2425 start-notebook.sh --ServerApp.token=''

Este es el que funciona correctamente:

docker run --user root -e NB_UID=1000 -e NB_GID=100 -e CHOWN_HOME=yes -e CHOWN_HOME_OPTS='-R' -it --rm --name="AIBA" -v "${PWD}:/home/jovyan/work" -p 8888:8888 gria-abia2425 start-notebook.sh --ServerApp.token=''

```

Una vez ejecutado el comando, podremos entrar al servidor de Jupyter Notebook a través de un navegador, en la dirección **[http://127.0.0.1:8888](http://127.0.0.1:8888)**.

Finalmente, para cerrar el contenedor (**asegúrate antes de haber guardado los cambios en los Notebooks**) pulsaremos `Control-C` en la terminal en la que ejecutamos el comando.

</div>


