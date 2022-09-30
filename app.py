from sanic import Sanic
from sanic.response import text

app = Sanic(__name__)

@app.get("/users")
async def users(request):
    return text("jose maria joao")

if __name__ == "__main__":
    app.run()
