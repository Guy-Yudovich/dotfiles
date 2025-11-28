from importlib.util import find_spec as ___find_spec
def ___is_importable(name: str) -> bool:
    return ___find_spec(name) is not None

from typing import *
from typing_extensions import *
from enum import Enum, Flag
import os, sys, json, re, enum, functools, itertools, inspect, subprocess

if ___is_importable("pydantic"):
    import pydantic
    from pydantic import BaseModel, ConfigDict
    
if ___is_importable("pydantic-settings"):
    import pydantic_settings
    from pydantic_settings import BaseSettings
    
if ___is_importable("pandas"):
    import pandas
    import pandas as pd
    
if ___is_importable("numpy"):
    import numpy
    import numpy as np

del ___find_spec, ___is_importable
