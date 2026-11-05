function show(pics, label){
  document.getElementById("count").textContent = pics.length + " pics - via " + label;
  document.getElementById("grid").innerHTML = pics.map(p =>
    `<img src="pics/${p}" class="w-full aspect-square object-cover rounded-xl shadow-lg">`
  ).join("");
}
fetch("http://localhost:8082/api/pics")
  .then(r => r.json())
  .then(d => show(d.pics, "REST"));
