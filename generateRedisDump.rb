def getEmployersDump
  employers = ''
  1.upto(10) do |i|
    employers = employers + "HMSET empregado:#{i} name #{getRandomName()} desc \"FullStack Developer\" salary 100 cod_dep #{Random.rand(1..2)}\n"
  end
  employers
end

def getDepartamentDump
  departaments = ''
  1.upto(2) do |i|
    departaments = departaments + "HMSET departamento:#{i} name #{getRandomDepartament()} \n"
  end
  departaments
end

def getRandomName
  names = ["Tony", "Andre", "Daeuble", "Victor"]
  rand_number = Random.rand(1..names.length) - 1
  names[rand_number]
end

def getRandomDepartament
  deps = ["TI","Atacado","Auditoria","Comercial","Credito","Legal","Manutencao","Marketing","Sales","RH","Varejo","Operações","Seguros","Tesouraria","Fiscal","Garantia","Sanitaria","Festas","Money"]
  rand_number = Random.rand(1..deps.length) - 1
  deps[rand_number]
end


def generateDumpData
  dump = getEmployersDump()
  dump = dump + "\n\n" +getDepartamentDump()

  File.delete "redisInsertDump.txt"
  File.write "redisInsertDump.txt", dump
end

def generateClearDump
  clear_dump = ''
  1.upto(10) do |i|
    clear_dump = clear_dump + "DEL empregado:#{i}\n"
  end

  1.upto(2) do |i|
    clear_dump = clear_dump + "DEL departamento:#{i}\n"
  end

  File.delete "redisClearDump.txt"
  File.write "redisClearDump.txt", clear_dump
end


generateDumpData()
generateClearDump()
