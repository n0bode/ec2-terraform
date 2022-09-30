from sanic import Sanic
from sanic.response import text

app = Sanic(__name__)
    
@app.get("/")
async def index(request):
    return text("running.0")