from setuptools import find_packages, setup


setup(
    name='prop13_utils',
    version="0.0.0",
    description='Utility functions for Prop-13 Analysis',
    author='Eve Liao',
    author_email='lay@berkley.edu',
    url='https://github.com/OtheringBelonging/Prop-13/tree/main/Python',
    packages=find_packages(exclude=['*.tests.*', 'docs']),
    include_package_data=True,
    package_data={'': ['data/*']},
    license='Private',
)
