#pragma checksum "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "752181c17c720d487dc081557521bc700534181f"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Aluno_Consulta), @"mvc.1.0.view", @"/Views/Aluno/Consulta.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\_ViewImports.cshtml"
using YouPlay2019;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\_ViewImports.cshtml"
using YouPlay2019.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"752181c17c720d487dc081557521bc700534181f", @"/Views/Aluno/Consulta.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"af76f6d9b592c63132cbc5ec1addda7d6b86b45c", @"/Views/_ViewImports.cshtml")]
    public class Views_Aluno_Consulta : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<List<YouPlay2019.Models.AlunoViewModel>>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "Pesquisar", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("method", "post", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
  
    ViewData["Title"] = "Consulta";

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n<header>\r\n    <h2 class=\"text-center\">Consulta de Alunos</h2>\r\n</header>\r\n\r\n");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("form", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "752181c17c720d487dc081557521bc700534181f4232", async() => {
                WriteLiteral(@"
    <div class=""form-group"">
        <div class=""row"">
            <div class=""col-md-3 mb-2"">
                <label for=""Codigo"" class=""text-black-50"">Código</label>
                <input id=""Codigo"" name=""Codigo"" type=""number"" class=""form-control round-custom"" />
            </div>
            <div class=""col-md-3 mb-2"">
                <label for=""Nome"" class=""text-black-50"">Nome</label>
                <input id=""Nome"" name=""Nome"" type=""text"" class=""form-control round-custom"" />
            </div>
            <div class=""col-md-3 mb-2"">
                <label for=""DataMatricula"" class=""text-black-50"">Data de matrícula</label>
                <input id=""DataMatricula"" name=""DataMatricula"" type=""date"" class=""form-control round-custom"" />
            </div>
            <div class=""col-md-3 mb-2"">
                <label for=""Disciplina"" class=""text-black-50"">Disciplina</label>
                <input id=""Disciplina"" name=""Disciplina"" type=""text"" class=""form-control round-custom"" />
       ");
                WriteLiteral("     </div>\r\n        </div>\r\n\r\n        <div class=\"row\">\r\n            <div class=\"col-md-12 mb-2\">\r\n                <input type=\"submit\" value=\"Pesquisar\" class=\"btn btn-primary round-custom\" />\r\n            </div>\r\n        </div>\r\n\r\n");
#nullable restore
#line 38 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
         if (ViewBag.Erro != null)
        {

#line default
#line hidden
#nullable disable
                WriteLiteral("            <div class=\"row\">\r\n                <div class=\"col-md-12\">\r\n                    <span class=\"text-danger\">");
#nullable restore
#line 42 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
                                         Write(ViewBag.Erro);

#line default
#line hidden
#nullable disable
                WriteLiteral("</span>\r\n                </div>\r\n            </div>\r\n");
#nullable restore
#line 45 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
        }

#line default
#line hidden
#nullable disable
                WriteLiteral("    </div>\r\n");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Action = (string)__tagHelperAttribute_0.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_0);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Method = (string)__tagHelperAttribute_1.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_1);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n\r\n");
#nullable restore
#line 49 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
 if (Model == null && ViewBag.Erro == null)
{

#line default
#line hidden
#nullable disable
            WriteLiteral("    <div class=\"form-group\">\r\n        <div class=\"row\">\r\n            <div class=\"col-md-12\">\r\n                <span class=\"text-danger\">\r\n                    Nenhum dado encontrado\r\n                </span>\r\n            </div>\r\n        </div>\r\n    </div>\r\n");
#nullable restore
#line 60 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
}
else
{

#line default
#line hidden
#nullable disable
            WriteLiteral(@"    <div class=""table-responsive-lg"">
        <table class=""table table-hover"">
            <thead class=""thead-dark"">
                <tr>
                    <th scope=""col"">Código</th>
                    <th scope=""col"">Nome</th>
                    <th scope=""col"">Data de matrícula</th>
                    <th scope=""col"">Status</th>
                    <th scope=""col"">Disciplina</th>
                    <th scope=""col"">Ação</th>
                </tr>
            </thead>
            <tbody>
");
#nullable restore
#line 76 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
                 foreach (var item in Model)
                {

#line default
#line hidden
#nullable disable
            WriteLiteral("                    <tr>\r\n                        <th scope=\"row\">");
#nullable restore
#line 79 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
                                   Write(item.Codigo);

#line default
#line hidden
#nullable disable
            WriteLiteral("</th>\r\n                        <td>");
#nullable restore
#line 80 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
                       Write(item.Nome);

#line default
#line hidden
#nullable disable
            WriteLiteral("</td>\r\n                        <td>");
#nullable restore
#line 81 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
                       Write(item.DataMatricula);

#line default
#line hidden
#nullable disable
            WriteLiteral("</td>\r\n                        <td>");
#nullable restore
#line 82 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
                       Write(item.CodigoStatus);

#line default
#line hidden
#nullable disable
            WriteLiteral("</td>\r\n                        <td>");
#nullable restore
#line 83 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
                       Write(item.DescricaoDisciplina);

#line default
#line hidden
#nullable disable
            WriteLiteral("</td>\r\n                        <td>\r\n                            <a");
            BeginWriteAttribute("href", " href=\"", 2990, "\"", 3033, 3);
            WriteAttributeValue("", 2997, "javascript:editarAluno(", 2997, 23, true);
#nullable restore
#line 85 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
WriteAttributeValue("", 3020, item.Codigo, 3020, 12, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 3032, ")", 3032, 1, true);
            EndWriteAttribute();
            WriteLiteral(">Editar</a> |\r\n                            <a");
            BeginWriteAttribute("href", " href=\"", 3079, "\"", 3122, 3);
            WriteAttributeValue("", 3086, "javascript:apagarAluno(", 3086, 23, true);
#nullable restore
#line 86 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
WriteAttributeValue("", 3109, item.Codigo, 3109, 12, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 3121, ")", 3121, 1, true);
            EndWriteAttribute();
            WriteLiteral(">Apagar</a>\r\n                        </td>\r\n                    </tr>\r\n");
#nullable restore
#line 89 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
                }

#line default
#line hidden
#nullable disable
            WriteLiteral("            </tbody>\r\n        </table>\r\n    </div>\r\n");
#nullable restore
#line 93 "C:\Users\thiag\OneDrive\Área de Trabalho\YouPlay2019\YouPlay2019\Views\Aluno\Consulta.cshtml"
}

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<List<YouPlay2019.Models.AlunoViewModel>> Html { get; private set; }
    }
}
#pragma warning restore 1591
