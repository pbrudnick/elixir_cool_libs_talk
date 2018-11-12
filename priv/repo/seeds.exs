# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SpeciesApp.Repo.insert!(%SpeciesApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias SpeciesApp.Species.Specie
alias SpeciesApp.Repo

%Specie{name_es: "Hornero", ebird_id: "rufhor2", name_en: "Rufous Hornero", name_pt: "João-de-barro", sci_name: "Furnarius rufus", regions: ["pampas", "litoral", "cuyo y centro"], difficulty: 5, status: "LC", active: true, picture: "https://upload.wikimedia.org/wikipedia/commons/f/f3/Rufous_hornero_%28Red_ovenbird%29%28Furnarius_rufus%29_and_nest_%282%29.JPG"} |> Repo.insert!
%Specie{name_es: "Macá Grande", ebird_id: "gregre1", name_en: "Great Grebe", name_pt: "Mergulhao-grande", sci_name: "Podiceps major", regions: ["pampas", "litoral", "cuyo y centro", "noroeste", "patagonia"], difficulty: 5, status: "LC", active: true} |> Repo.insert!
%Specie{name_es: "Remolinera Araucana", ebird_id: "dabcin1", name_en: "Dark-bellied Cinclodes", name_pt: "", sci_name: "Cinclodes patagonicus", regions: ["patagonia"], difficulty: 3, status: "LC", active: true} |> Repo.insert!
%Specie{name_es: "Tachurí Siete Colores", ebird_id: "mcrtyr1", name_en: "Many-colored Rush-tyrant", name_pt: "Papa-piri", sci_name: "Tachuris rubrigastra", regions: ["pampas", "litoral", "cuyo y centro", "patagonia"], difficulty: 4, status: "LC", active: true} |> Repo.insert!
%Specie{name_es: "Benteveo Común", ebird_id: "grekis", name_en: "Great Kiskadee", name_pt: "Bem-te-vi", sci_name: "Pitangus sulphuratus", regions: ["pampas", "litoral", "patagonia"], difficulty: 4, status: "LC", active: true, picture: "https://c1.staticflickr.com/3/2177/2501230309_d5c16d23ee_z.jpg?zz=1"} |> Repo.insert!
%Specie{name_es: "Tacuarita Azul", ebird_id: "masgna1", name_en: "Masked Gnatcatcher", name_pt: "Balança-rabo-de-máscara", sci_name: "Polioptila dumicola", regions: ["pampas", "litoral", "cuyo y centro", "noroeste"], difficulty: 4, status: "LC", active: true, picture: "https://c1.staticflickr.com/3/2346/2442910575_b713a36aec_b.jpg"} |> Repo.insert!
