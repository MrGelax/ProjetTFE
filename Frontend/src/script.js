/* $(document).ready(function () {
    $('#sidebarToggleTop').on('click', function () {
      var x = document.getElementById("sidebar");
    x.style.display = "block";
    });

    $('#sidebarCollapse').on('click', function () {
      if (window.matchMedia("(min-width:700px)").matches) {
            $('.sidebar').toggleClass('active');
        }
       else {
        var x = document.getElementById("sidebar");
         if (x.style.display === "block") {
          
            x.style.display = "none";
           
          } 
        }});
    }) */

        /* Display buttons when radiobutton is selected */ 
        function showButtons(){
            document.getElementById('buttons').style.display = 'block';
          }
       
         
          /* delete everything if checkbox globally is selected */ 
          function deleteAll() {
            var checkBox = document.getElementById("deleteGlobally");
            var x = document.getElementById("radiobuttonsSections");
            if (checkBox.checked == true){
                x.remove(x.selectedIndex);
              }
          }
          
           
              /* show add/edit section */ 
          function addSection() {
            var x = document.getElementById("editSection");
            if (x.style.display === "none") {
              x.style.display = "block";
            } else {
              x.style.display = "block";
            }
      
            var x = document.getElementById("saveBtn");
            if (x.style.display === "none") {
              x.style.display = "block";
            } else {
              x.style.display = "block";
            }
      
            var x = document.getElementById("addSection");
            if (x.style.display === "block") {
              x.style.display = "none";
            } else {
              x.style.display = "none";
            }
      
            var x = document.getElementById("addBtn");
            if (x.style.display === "block") {
              x.style.display = "none";
            } else {
              x.style.display = "none";
            }
          }
      
      
              /* Display default result when cancel button is pressed */ 
          function cancel() {
            var x = document.getElementById("editSection");
            if (x.style.display === "block") {
              x.style.display = "none";
            } else {
              x.style.display = "none";
            }
      
            var x = document.getElementById("saveBtn");
            if (x.style.display === "block") {
              x.style.display = "none";
            } else {
              x.style.display = "none";
            }
            
            var x = document.getElementById("addSection");
            if (x.style.display === "none") {
              x.style.display = "block";
            } else {
              x.style.display = "block";
            } 
      
            var x = document.getElementById("addBtn");
            if (x.style.display === "none") {
              x.style.display = "block";
            } else {
              x.style.display = "block";
            } 
          }
      
         
          /* show table when checkbox setup is checked */ 
          function showTable() {
            var checkBox = document.getElementById("setupCheckbox");
            var x = document.getElementById("setupTable");
            if (checkBox.checked == true){
              x.style.display = "block";        
            }
            else {
              x.style.display = "none";        
            }
          }
          
          /* Drag and drop function */
          function allowDrop(ev) {
            ev.preventDefault();
          }
          
          function drag(ev) {
            ev.dataTransfer.setData("text", ev.target.id);
          }
          
          function drop(ev) {
            ev.preventDefault();
            var data = ev.dataTransfer.getData("text");
            ev.target.appendChild(document.getElementById(data));
          }
      //check in