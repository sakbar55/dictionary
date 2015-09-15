require "webrick"

class DisplayDictionary < WEBrick::HTTPServlet::AbstractServlet

  def do_GET(request, response)

    dictionary_lines = File.readlines("dictionary.txt")

    dictionary_html = "<ul>" + dictionary_lines.map { |line| "<li>#{line}</li>" }.join + "</ul>"

    response.status = 200
    response.body = %{
      <html>
        <body>
          <a href="/add"> To add a word, click here </a>
          <form method="POST" action="/search">
            <span>Search</span>
            <input name="to_search" type="search">
            <button type="submit"> Search it! </button>
          </form>
          <p>Dictionary</p>
          <p>#{dictionary_html}</p>
        </body>
      </html>
      }
  end
end

class AddWord < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)

    response.status = 200
    response.body = %{
      <html>
        <body>
          <form method="POST" action="/save">
          <ul>
            <li>Add Word to Dictionary:</li>
            <li><input name="word" /></li>
            <li>Add Definition:</li>
            <li><input name="definition" />
            <li><button type="submit">Add Word</button></li>
          </form>
          </ul>
        </body>
      </html>
    }
  end
end
