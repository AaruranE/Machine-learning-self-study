using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.IO;

namespace kmeans
{
    class Program
    {
        static void Main(string[] args)
        {


            string simple2 = @"C:/Users/Aaruran/Documents/GitHub/Machine learning Self-study/kmeans/data/simple2.csv";
            // -------------------------------------
            // Source : http://stackoverflow.com/questions/1166272/efficient-function-for-reading-a-delimited-file-into-datatable 
            IEnumerable<string> reader = ReadAsLines(simple2);
            var data = new DataTable();
            DataRow row =  new DataRow();

            var headers = reader.First().Split(',');
            foreach (var header in headers)
                data.Columns.Add(header);

            var records = reader.Skip(1);
            foreach (var record in records) 
            {
                var elements = record.Split(',');
                row.ItemArray = elements;
                data.Rows.Add(row);
                data.AcceptChanges();
                row = new DataRow();
            }
            
            // -------------------------------------
            string dtStr = data.ToString();
            Console.WriteLine(data.ToString());
            
            Console.WriteLine("");

        }

        // Source : http://stackoverflow.com/questions/1166272/efficient-function-for-reading-a-delimited-file-into-datatable 
        static IEnumerable<string> ReadAsLines(string filename)
        {
            using (var reader = new StreamReader(filename))
                while (!reader.EndOfStream)
                    yield return reader.ReadLine();
        }


    }
}
