"""
Setup module.
"""
import setuptools

LONG_DESCRIPTION = """
Functions to access files on an MTP device (smartphone, etc.) under Windows and Linux.
Only some directory and file access and functions are implemented. For example:

✔️ Get all MTP devices
✔️ Scan directories
✔️ Create/delete directories
✔️ Read/Write/delete files

👀 Check out the documentation in the docs folder


## Installation

```python
python -m pip install mtp
"""

setuptools.setup(
    name="mtp",
    version="1.3.0",
    author="Heribert Füchtenhans",
    author_email="heribert.fuechtenhans@yahoo.de",
    description="Functions to access files on an MTP device (smartphone, etc.) under Windows and Linux.",
    long_description=LONG_DESCRIPTION,
    long_description_content_type="text/markdown",
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: Microsoft :: Windows",
        "Operating System :: Linux :: Mint",
    ],
    url="https://github.com/heribert17/mtp",
    package_dir={"": "src"},
    packages=setuptools.find_packages(where="src"),
    install_requires=["comtypes>=1.4.10"],
    python_requires=">=3.10",
    include_package_data=True,
    package_data={'mtp': ['images/*.*']}
)
