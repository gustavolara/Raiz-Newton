using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

// Aplicação do método de Newton para o cálculo da raiz quadrada de um número inteiro qualquer
namespace Raiz_Newton
{
    class Program
    {
        static int INum;
        static int ICont;
        static double DX0;
        static void Main(string[] args)
        {
            ICont = 0;
            Console.WriteLine("Digite o número => ");
            INum = Convert.ToInt32(Console.ReadLine());
            DX0 = INum / 2; // "Chute" inicial
            DX0 = Raiz(DX0);
            Console.WriteLine("A raiz de {0} é {1} !", INum, DX0 );
            Console.ReadKey();
        }
        static double Raiz(double DX0)
        {

            // Fórmula aplicada:
            // x[k+1]= x[k] * ( f(x[k]) / f'(x[k]) )
            // onde:
            // f(x[k]) = x^2 - (num)
            // f'(x[k]) = 2*x  **Inversa de f(x[k])
            // x[k] = "chute"
            // x[k+1] = raiz ou o "chute" para o próximo ciclo

            double DX1, DFX, DFiX;
            DFX = DX0 * DX0;  // Aplicação do método de Newton
            DFX = DFX - INum;
            DFiX = DX0 * 2;
            DX1 = DFX / DFiX;
            DX1 = DX0 - DX1;
            ICont = ICont + 1; // Contador
            DX0 = DX1; // Definição do "chute" para o próximo ciclo
            if (ICont < 10)
            { // 10 ciclos para ganhar precisão
               DX0 = Raiz(DX0);
            }
            return DX0;
        }

    }
}