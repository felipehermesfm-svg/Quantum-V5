import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  console.log('Iniciando teste de banco de dados...');
  
  // Criando um registro apenas com os campos que o seu Prisma aceitou
  const novoDia = await prisma.tradingDay.create({
    data: {
      resultadoDia: 150.75,
      winrate: 65.5,
      date: new Date(),
    },
  });

  console.log('✅ Sucesso! Criado dia com ID:', novoDia.id);
}

main()
  .catch((e) => {
    console.error('❌ Erro no teste:', e.message);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });