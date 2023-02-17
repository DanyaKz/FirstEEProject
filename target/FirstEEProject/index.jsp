<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Home page</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
</head>
<body>

    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="num">#</th>
                <th scope="model">Model</th>
                <th scope="price">Price</th>
                <th scope="count">Count</th>
                <th scope="act">Action</th>
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
                <td>
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                            data-bs-target="#deleteModal" onclick="setDeleteId(<%= laptop.get("id")%>)">Delete</button>
                    <a type="button" class="btn btn-info" data-bs-toggle="modal"
                       data-bs-target="#updModal" onclick="setEditData(<%= laptop.get("id")%>)">Edit</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <button type="button" class="btn btn-success"
            data-bs-toggle="modal" data-bs-target="#addModal">Add a product</button>




<%--    Delete modal --%>
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete window</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure ?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <a id="confirmDelete" href="" class="btn btn-primary">Yes</a>
                </div>
            </div>
        </div>
    </div>
<%--    --%>



<%--    Add modal --%>
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add window</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form class="row g-3" action="add" method="post">
                    <div class="modal-body">
                        <div class="col-auto">
                            <input name = "model" type="text" class="form-control"  placeholder="Model">
                            <input name = "price" type="number" class="form-control"  placeholder="Price">
                            <input name = "count" type="number" class="form-control"  placeholder="Count">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">Add</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
<%--    --%>


<%--    Update modal --%>
    <div class="modal fade" id="updModal" tabindex="-1" aria-labelledby="updModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit window</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form class="row g-3" action="update" method="post">
                    <div class="modal-body">
                        <div class="col-auto">
                            <input name = "model" type="text" class="form-control" id="model" placeholder="Model">
                            <input name = "price" type="number" class="form-control" id="price" placeholder="Price">
                            <input name = "count" type="number" class="form-control" id="count" placeholder="Count">
                            <input type="hidden" name = "id" id = "updId">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">Submit</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
<%--    --%>




    <script src = "scripts.js" type="text/javascript"></script>

    <script>
    function setDeleteId(productId){
        document.getElementById('confirmDelete').href
            =`delete?id=${productId}`;
    }
    </script>

    <script>
        function setEditData(productId){
            $.ajax({
                url: `update?id=${productId}`
            }).done(function(res){
                console.log(res);
                let data = JSON.parse(res);
                console.log(data);
                document.getElementById("model").value = data.model;
                document.getElementById("price").value = data.price;
                document.getElementById("count").value = data.count;
                document.getElementById('updId').value = data.id;
            })
        }
    </script>


</body>
</html>