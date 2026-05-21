from fastapi import APIRouter

router = APIRouter(
    prefix="/cart",
    tags=["Cart"]
)

fake_cart = [
    {
        "id": 1,
        "name": "Nike Air Max",
        "price": 120,
        "image": "https://picsum.photos/200"
    },
    {
        "id": 2,
        "name": "Adidas Hoodie",
        "price": 80,
        "image": "https://picsum.photos/201"
    }
]

@router.get("/")
def get_cart():
    return fake_cart