from pydantic import BaseModel
from typing import Optional

class Recipe(BaseModel):
    id: int
    title: str
    image: str
    match_percentage: int
    used_ingredient_count: int
    missed_ingredient_count: int
    likes: int
