package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import finalDominio.Carrinho;
import finalDominio.Cartao;
import finalDominio.Cupom;
import finalDominio.CupomTroca;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;

public class PedidoDAO extends AbstractJdbcDAO{
	public PedidoDAO() {
		super("pedido", "id_pedido");
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Carrinho carrinho = (Carrinho)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO pedido (id_cliente, email_cliente, id_endereco, valor_frete, valor_livros, valor_total, status, data_criacao, id_cupom) ");
			sql.append("VALUES (?,?,?,?,?,?,?,sysdate(),?)");
			
			pst = connection.prepareStatement(sql.toString(), 
                    Statement.RETURN_GENERATED_KEYS);
			pst.setInt(1, carrinho.getID_Cliente());
			pst.setString(2, carrinho.getEmail());
			pst.setInt(3, carrinho.getEnderecoEntrega().getId());
			pst.setDouble(4, carrinho.getFrete());
			pst.setDouble(5, carrinho.getValorLivros());
			pst.setDouble(6, carrinho.getValorTotal());
			pst.setString(7, carrinho.getStatus());
			pst.setInt(8, carrinho.getCupomDesconto().getId());
			
			pst.executeUpdate();
			ResultSet rs = pst.getGeneratedKeys();
            int id=0;
            if(rs.next())
            {
                id = rs.getInt(1);
            }
            carrinho.setId(id);
			connection.commit();
			
			for(Produto p:carrinho.getProdutos()) {
				sql = new StringBuilder();
				sql.append("INSERT INTO produto (ID_Pedido, ID_Livro, quantidade) ");
				sql.append("VALUES (?,?,?)");
				
				pst = connection.prepareStatement(sql.toString(), 
	                    Statement.RETURN_GENERATED_KEYS);
				pst.setInt(1, carrinho.getId());
				pst.setInt(2, p.getLivro().getId());
				pst.setInt(3, p.getQuantidade());
				
				pst.executeUpdate();
				rs = pst.getGeneratedKeys();
	            id=0;
	            if(rs.next())
	            {
	                id = rs.getInt(1);
	            }
	            p.setId(id);
				connection.commit();
			}
			
			for(Cartao c:carrinho.getCartoes()) {
				sql = new StringBuilder();
				sql.append("INSERT INTO cartao_compra (ID_Cartao, ID_Pedido, Valor) ");
				sql.append("VALUES (?,?,?)");
				
				pst = connection.prepareStatement(sql.toString(), 
	                    Statement.RETURN_GENERATED_KEYS);
				pst.setInt(1, c.getId());
				pst.setInt(2, carrinho.getId());
				pst.setDouble(3, c.getCredito());
				
				pst.executeUpdate();
				rs = pst.getGeneratedKeys();
	            id=0;
	            if(rs.next())
	            {
	                id = rs.getInt(1);
	            }
	            c.setId(id);
				connection.commit();
			}
			pst.close();
		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();			
		}finally{
			try {
				pst.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Carrinho carrinho = (Carrinho)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE pedido SET status = ? WHERE ID_pedido = ?");
			System.out.println(sql.toString());
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, carrinho.getStatus());
			pst.setInt(2, carrinho.getId());
			System.out.println(pst);
			pst.executeUpdate();
			connection.commit();
		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();			
		}finally{
			try {
				pst.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		PreparedStatement pst = null;
		Carrinho carrinho = (Carrinho) entidade;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT * FROM pedido ");
		//sb.append("LEFT JOIN PRODUTO using(id_pedido)");
		//sb.append("LEFT JOIN CARTAO_COMPRA using(id_pedido)");
		sb.append("LEFT JOIN CUPOM_DESCONTO on(id_cupom = id_cupom_desconto)");
		sb.append("LEFT JOIN ENDERECO using(id_endereco)");
		//sb.append("LEFT JOIN livros using(id_livro)");
		sb.append("WHERE 1=1");
		if(carrinho.getEmail() != null && carrinho.getEmail().length() > 0)
			sb.append(" AND email_cliente = '" + carrinho.getEmail() + "'");
		if(carrinho.getID_Cliente() > 0)
			sb.append(" AND ID_Cliente = '" + carrinho.getEmail() + "'");
		if(carrinho.getStatus() != null && carrinho.getStatus().length() > 0)
			sb.append(" AND status = '" + carrinho.getStatus() + "'");
		sb.append(" order by(id_pedido)");
		
		try {
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> pedidos = new ArrayList<>();
			ProdutoDAO produtoDAO = new ProdutoDAO();
			EnderecoDAO enderecoDAO = new EnderecoDAO();
			while(rs.next()){
				Carrinho c = new Carrinho();
				Cartao cartao = new Cartao();
				c.setId(rs.getInt("ID_Pedido"));
				c.setIdEndereco(rs.getInt("id_endereco"));
				c.setStatus(rs.getString("status"));
				c.setFrete(rs.getDouble("valor_frete"));
				c.setValorLivros(rs.getDouble("valor_livros"));
				c.setValorTotal(rs.getDouble("valor_total"));
				c.setEmail(rs.getString("email_cliente"));
				c.setID_Cliente(rs.getInt("id_cliente"));
				
				//Criando um objeto de edere�o para chamar a dao
				Endereco endereco = new Endereco();
				endereco.setId(c.getIdEndereco());
				/*
				 * Pegando o endere�o utilizado
				 * */
				endereco = (Endereco)enderecoDAO.consultar(endereco).get(0);
				c.setEnderecoEntrega(endereco);
				
				/*
				 * Pegando todos os produtos do pedido
				 * */
				produtoDAO.consultar(c);
				
				/*
				 * Pegar todos os cart�es utilizados no pedido
				 * */
				CartaoDAO cartaoDAO = new CartaoDAO();
				StringBuilder sql = new StringBuilder();
				sql.append("SELECT * FROM CARTAO_COMPRA ");
				sql.append(" WHERE ID_Pedido = '" + c.getId() + "'");
				PreparedStatement pstCartao = connection.prepareStatement(sql.toString());
				ResultSet rsC = pstCartao.executeQuery();
				while(rsC.next()){
					cartao.setId(rsC.getInt("ID_Cartao"));
					cartao = (Cartao)cartaoDAO.consultar(cartao).get(0);
					cartao.setCredito(rsC.getDouble("valor"));
					
					c.getCartoes().add(cartao);
				}
				pedidos.add(c);
			}
			return pedidos;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		/* 
		try{
			while(rs.next()){
				Carrinho c = new Carrinho();
				c.setId(rs.getInt("ID_Carrinho"));
				c.setIdEndereco(rs.getInt("id_endereco"));
				c.setStatus(rs.getString("status"));
				c.setFrete(rs.getDouble("valor_frete"));
				c.setValorLivros(rs.getDouble("valor_livros"));
				c.setValorTotal(rs.getDouble("valor_total"));
				c.setEmail(rs.getString("email_cliente"));
				c.setID_Cliente(rs.getInt("id_cliente"));
				//Pegar os cupons utilizados na compra
				sb = new StringBuilder();
				pst = null;
				sb.append("SELECT * FROM CUPONS WHERE ID_Cupom = " + rs.getInt("id_cupom"));
				pst = connection.prepareStatement(sb.toString());
				ResultSet rst = pst.executeQuery();
				while(rst.next()) {
					if(rs.getInt("id_cupom") == rst.getInt("id_cupom")) {
						Cupom cupom = new Cupom();
						cupom.setId(rst.getInt("id_cupom"));
						cupom.setCodigo(rst.getString("codigo"));
						cupom.setValor(rst.getDouble("valor"));
						c.setCupom(cupom);
					}
				}
				//Pegar o endere�o de entrega
				sb = new StringBuilder();
				pst = null;
				sb.append("SELECT * FROM ENDERECO WHERE ID_Endereco = " + rs.getInt("id_endereco"));
				pst = connection.prepareStatement(sb.toString());
				rst = pst.executeQuery();
				while(rst.next()) {
					if(rs.getInt("id_endereco") == rst.getInt("id_endereco")) {
						Endereco e = new Endereco();
						e.setId(rs.getInt("ID_Endereco"));
						e.setPreferencial(rst.getBoolean("preferencial"));
						e.setTipoResidencia(rst.getString("tipo_residencia"));
						e.setTipoLogradouro(rst.getString("tipo_logradouro"));
						e.setLogradouro(rst.getString("logradouro"));
						e.setNumero(rst.getString("numero"));
						e.setBairro(rst.getString("bairro"));
						e.setCep(rst.getString("CEP"));
						e.setCidade(rst.getString("cidade"));
						e.setEstado(rst.getString("estado"));
						e.setPais(rst.getString("pais"));
						e.setObservacao(rst.getString("obs"));
						e.setID_Cliente(rst.getInt("ID_Cliente"));
						e.setAlterador(rst.getString("alterador"));
						c.setEnderecoEntrega(e);
					}
				}
				//Pegar o cart�o
				sb = new StringBuilder();
				pst = null;
				sb.append("SELECT * FROM CARTAO WHERE ID_Cartao = " + rs.getInt("id_cartao"));
				pst = connection.prepareStatement(sb.toString());
				rst = pst.executeQuery();
				while(rst.next()) {
					if(rs.getInt("id_cartao") == rst.getInt("id_cartao")) {
						Cartao ca = new Cartao();
						ca.setId(rst.getInt("ID_cartao"));
						ca.setTitular(rst.getString("titular"));
						ca.setNumero(rst.getString("numero"));
						ca.setCodigo(rst.getString("codigo"));
						Calendar calendV = Calendar.getInstance();
						calendV.setTime(rst.getDate("validade"));
						ca.setValidade(calendV);
						ca.setID_Cliente(rst.getInt("id_cliente"));
						ca.setAlterador(rst.getString("alterador"));
						ca.setPreferencial(rst.getBoolean("preferencial"));
						ca.setBandeira(rst.getString("bandeira"));
						c.setCartao(ca);
					}
				}
				//Pegar os produtos referentes ao pedido
				sb = new StringBuilder();
				pst = null;
				sb.append("SELECT * FROM PRODUTO JOIN LIVROS using(id_livro) WHERE ID_Carrinho = " + rs.getInt("id_carrinho"));
				pst = connection.prepareStatement(sb.toString());
				rst = pst.executeQuery();
				while(rst.next()) {
					if(rs.getInt("id_carrinho") == rst.getInt("id_carrinho")) {
						Livro l = new Livro();
						Produto p = new Produto();
						l.setId(rst.getInt("ID_Livro"));
						l.setAutor(rst.getString("autor"));
						l.setCategoria(rst.getString("categoria"));
						l.setSubcategoria(rst.getString("subcategoria"));
						l.setAno(rst.getString("ano"));
						l.setTitulo(rst.getString("titulo"));
						l.setEditora(rst.getString("editora"));
						l.setEdicao(rst.getString("edicao"));
						l.setISBN(rst.getString("isbn"));
						l.setNpaginas(rst.getString("npaginas"));
						l.setSinopse(rst.getString("sinopse"));
						l.setStatus(rst.getBoolean("status"));
						l.setAltura(rst.getDouble("altura"));
						l.setLargura(rst.getDouble("largura"));
						l.setPeso(rst.getDouble("peso"));
						l.setProfundidade(rst.getDouble("profundidade"));
						l.setAlterador(rst.getString("alterador"));
						l.setPreco(rst.getDouble("preco"));
						l.setValor(rst.getDouble("valor"));
						l.setPrecificacao(rst.getString("precificacao"));
						l.setEstoque(rst.getInt("estoque"));
						p.setLivro(l);
						p.setID_Carrinho(rst.getInt("ID_Carrinho"));
						p.setId(rst.getInt("ID_Produto"));
						p.setQuantidade(rst.getInt("quantidade"));
						c.getProdutos().add(p);
					}
				}
				carrinhos.add(c);
			}
			return carrinhos;
		}catch(SQLException e){
			e.printStackTrace();
		}*/
		return null;
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}
}
