function updateForm(formElt) {
    let controlsToReq = ['FirstName', 'LastName'];
    let actionsToReq = ['query', 'add', 'delete'];
    let reqOrNot = actionsToReq.includes(formElt.to_do.value);
    for (let name of controlsToReq) {
        let control = formElt.querySelector('input[name=' + name + ']');
        control.toggleAttribute('required', reqOrNot);
    } 

}