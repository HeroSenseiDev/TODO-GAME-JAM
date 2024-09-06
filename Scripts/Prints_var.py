


print("@onready var Cuadrilla = {\n")

for i in range(9):
    print(
        f"'Casilla_{i+1}':"
        "{\n"
        f"     'Position':$Cuadrillas/Casilla_{i+1}.global_position,\n"
        f"     'Select':$Cuadrillas/Casilla_{i+1}/TextureRect2,\n"
        f"     'Have':null,\n"
        f"     'How':'',\n"
        f"     'Rombo':$Cuadrillas/Casilla_{i+1}/Rombo,\n"
        f"     'Circulo':$Cuadrillas/Casilla_{i+1}/Circulo,\n"
        "},"
        )
    
print("}")
    