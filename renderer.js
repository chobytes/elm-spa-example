Elm = require ("./dist/elm-bundle.js")

App = Elm.Main.fullscreen()
//App = Elm.Main.embed(document.getElementById("body"))

App.ports.getUser.subscribe(user =>
    fetch(`https://api.github.com/users/${user}`)
        .then(res => res.json())
        .then(res => App.ports.receiveUser.send(res)))

App.ports.search.subscribe(q =>
    fetch(`https://api.github.com/search/repositories?q=${q}`)
        .then(res => res.json())
        .then(res =>App.ports.getSearchResult.send(res)))
