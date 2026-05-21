from fastapi import FastAPI
from database import engine
import models

from routers import auth_router, product_router, cart_router

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(auth_router.router)
app.include_router(product_router.router)
app.include_router(cart_router.router)

@app.get("/")
def root():
    return {"message": "MegaShop API Running"}