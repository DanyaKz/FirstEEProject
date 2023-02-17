function setDeleteId(productId){
    document.getElementById('confirmDelete').href
        =`delete?id=${productId}`;
}

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
