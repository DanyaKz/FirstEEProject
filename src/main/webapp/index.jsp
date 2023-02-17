<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Home page</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body>

    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="num">#</th>
                <th scope="model">Model</th>
                <th scope="price">Price</th>
                <th scope="count">Count</th>
            </tr>
        </thead>

        <tbody>
            <%
                List<HashMap<String, Object>> laptops =
                        (List<HashMap<String,java.lang.Object>>) request.getAttribute("laptops");
                for (HashMap<String, Object> laptop: laptops){
            %>

            <tr>
                <th><%= laptop.get("id")%></th>
                <td><%= laptop.get("model")%></td>
                <td><%= laptop.get("price")%></td>
                <td><%= laptop.get("count")%></td>
            </tr>

            <% } %>
        </tbody>
    </table>

</body>
</html>