from conan import ConanFile

class MoaryStudio(ConanFile):

    generators = ["CMakeDeps", "CMakeToolchain"]
    settings = "os", "compiler", "build_type", "arch"
    # Dynamically define requirements with potential overrides
    def requirements(self):
        self.requires("libsndfile/1.2.2")
        self.requires("taglib/2.0")

        #self.requires("freetype/2.13.2", override=True)
        #self.requires("libpng/1.6.42", override=True)

    def build_requirements(self):
        self.tool_requires("cmake/3.28.1")
