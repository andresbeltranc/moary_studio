# moary_studio



### Setting up Conan:
To compile the app, you need to have conan installed and configured on your system. You need to make sure to configure conan using the same compiler as QT.
When you've run conan you should see a folder in the following path: C:/Users/[Your User]/.conan `https://docs.conan.io/2/tutorial.html`

This folder contains any libraries you install as well as some configuration files of the default profile file doesn't exist you would have to run the folowing command:
`conan profile detect`

Please edit the following file: C:/Users/[Your User]/.conan2/profiles/default
Make sure it includes the following configuration:

```
[settings]
arch=x86_64
build_type=Release
compiler=msvc
compiler.cppstd=17
compiler.runtime=dynamic
compiler.version=192
os=Windows
```

Since we use MSVC as our compiler in QT and Visual Studio, we need to make sure that conan uses the same one.

After conan is installed and configured, you can install the necessary dependencies by running the following command in the root of the project
(rigth now the dependency of openvino doesn't support Debug mode):

`conan install . -of ./src/libs/conan_libs  -s build_type=Release --build=missing`

`conan install . -of ./src/libs/conan_libs  -s build_type=Debug --build=missing`
 
To Modify the Moary Studio dependencies you would have to modify the conanfile.py file.
