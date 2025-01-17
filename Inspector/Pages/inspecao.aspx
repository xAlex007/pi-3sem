﻿<%@ Page Title="Inspeção | Inspector" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="inspecao.aspx.cs" Inherits="Pages_plans" %>

<asp:Content ID="Head" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.1.1/dist/select2-bootstrap-5-theme.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script title="Select2" type="text/javascript">
        $(document).ready(function () {
            $("#ddl_planos").select2({
                theme: "bootstrap-5",
                dropdownParent: $("#newModal"),
                placeholder: "Escolha",
                allowClear: true
            });
        });
        $(document).on('select2:open', () => {
            document.querySelector('.select2-search__field').focus();
        });
    </script>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="render" runat="Server">
    <div class="container">
        <div class="row h-100 py-2" style="font-size:1.25rem;">
            <!--Cabeçalho-->
            <div id="ins_head" class="row centered" style="display: none;" runat="server">
                <div class="col-12 col-md-9 col-lg-7 col-xl-5 ms-4 ms-sm-0 text-center fw-bold border border-2 rounded-1 border-success bg-header align-self-end">
                    <div class="row row-cols-1">
                        <div class="col border rounded-1 border-success pt-4 pb-3">
                            <asp:Label CssClass="fw-normal" runat="server" Text="Ordem de Produção: "><asp:Label CssClass="fw-bold" ID="l_op" runat="server"></asp:Label></asp:Label>
                        </div>
                    </div>
                    <div class="row row-cols-2">
                        <div class="col border rounded-1 border-success p-center">
                            <asp:Label CssClass="fw-normal" runat="server" Text="Produto: "><asp:Label CssClass="fw-bold" ID="l_prod" runat="server"></asp:Label></asp:Label>
                        </div>
                        <div class="col border rounded-1 border-success p-center">
                            <asp:Label CssClass="fw-normal" runat="server" Text="Desenho: "><asp:HyperLink CssClass="fw-bold" ID="l_desp" runat="server"></asp:HyperLink></asp:Label>
                        </div>
                    </div>
                    <div class="row row-cols-1">
                        <div class="col border rounded-1 border-success p-center">
                            <asp:Label CssClass="fw-normal" runat="server" Text="Corrida: "><asp:Label CssClass="fw-bold" ID="l_corr" runat="server"></asp:Label></asp:Label>
                        </div>
                    </div>
                    <div class="row row-cols-2">
                        <div class="col border rounded-1 border-success p-center">
                            <asp:Label ID="l_cotas" runat="server" Text="Nº COTA"></asp:Label>
                        </div>
                        <div class="col border rounded-1 border-success p-center">
                            <asp:Label ID="l_valores" runat="server" Text="VALOR MEDIDO"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
            <!--Dados-->
            <div id="ins_data" class="row centered mt-1" style="display: none;" runat="server">
                <asp:Panel ID="pnl_regs" CssClass="col-12 col-md-9 col-lg-7 col-xl-5 ms-4 ms-sm-0 text-center border border-success rounded-1 bg-light align-self-start" runat="server"></asp:Panel>
                <div class="row centered gy-1">
                    <asp:Button ID="bSave" class="btn btn-outline-success pt-2" Width="200" runat="server" Text="Salvar" ValidationGroup="Save" OnClick="bSave_Click" />  
                </div>
            </div>
        </div>        
    </div>

    <!--Modal Nova Inspeção-->
    <div class="modal fade" id="newModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header justify-content-center">
                    <h4 class="modal-title fw-bold" id="staticBackdropLabel">Novo Registro de Inspeção</h4>
                </div>
                <div class="modal-body">
                    <div class="row centered">
                        <div class="col-6">
                            <asp:Label ID="l_plano" runat="server" Text="Ordem de Produção:"></asp:Label>
                            <asp:DropDownList ID="ddl_planos" AppendDataBoundItems="true" runat="server" ClientIDMode="Static">
                                <asp:ListItem Text="" Value=""/>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Campo obrigatório." ControlToValidate="ddl_planos" ValidationGroup="OK" CssClass="fst-italic fw-bold text-danger text-small"></asp:RequiredFieldValidator>
                            <br />
                            <asp:Label ID="l_newcorr" runat="server" Text="Corrida:"></asp:Label>
                            <asp:TextBox ID="i_newcorr" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Campo obrigatório." ControlToValidate="i_newcorr" ValidationGroup="OK" CssClass="fst-italic fw-bold text-danger text-small"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="bCancel" class="btn btn-outline-danger" runat="server" Text="Sair" OnClick="cancel_Click" />
                    <asp:Button ID="bOK" class="btn btn-outline-success" runat="server" Text="OK" ValidationGroup="OK" OnClick="bOK_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
