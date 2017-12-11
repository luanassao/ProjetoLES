package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

public class CarrinhoDAO extends AbstractJdbcDAO{
	public CarrinhoDAO() {
		super("carrinho", "id_carrinho");
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Carrinho carrinho = (Carrinho)entidade;
		System.out.println("Quantia de cupons: " + carrinho.getCupons().size());
		List<Carrinho> carrinhos = new ArrayList<>();
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE carrinho set status = 'TROCADO' WHERE ID_Carrinho = ?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setInt(1, carrinho.getIdPedido());
			System.out.println(pst);
			pst.executeUpdate();
			connection.commit();
			
			sql = new StringBuilder();
			sql.append("INSERT INTO carrinho(id_endereco, valor_frete, valor_livros, valor_total, id_cartao, data_criacao, ID_Cupom, id_cliente, email_cliente, status)");
			sql.append("VALUES (?,?,?,?,?,sysdate(),?,?,?,?)");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setInt(1, carrinho.getEnderecoEntrega().getId());
			pst.setDouble(2, carrinho.getFrete());
			pst.setDouble(3, carrinho.getValorLivros());
			pst.setDouble(4, carrinho.getValorTotal());
			pst.setInt(5, carrinho.getCartao().getId());
			pst.setInt(6, carrinho.getCupom().getId());
			pst.setInt(7, carrinho.getID_Cliente());
			pst.setString(8, carrinho.getEmail());
			pst.setString(9, carrinho.getStatus());
			pst.executeUpdate();
			connection.commit();
			pst.close();
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT ID_Carrinho FROM carrinho WHERE 1=1 order by 1");
			try{
				openConnection();
				pst = connection.prepareStatement(sb.toString());
				ResultSet rs = pst.executeQuery();
				while(rs.next()){
					if(rs.isLast())
					{
						Carrinho c = new Carrinho();
						c.setId(rs.getInt("ID_Carrinho"));
						carrinhos.add(c);
					}
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
			for(CupomTroca c : carrinho.getCupons())
			{
				System.out.println("Inserindo produto no carrinho: " + carrinhos.get(0).getId());
				try {
					connection.setAutoCommit(false);
					sql = new StringBuilder();
					sql.append("INSERT INTO cupom_compra(ID_Carrinho, ID_Cupom)");
					sql.append("VALUES (?,?)");
					
					pst = connection.prepareStatement(sql.toString());
					pst.setInt(1, carrinhos.get(0).getId());
					pst.setInt(2, c.getId());
					pst.executeUpdate();
					connection.commit();
					pst.close();
					
					sql = new StringBuilder();
					sql.append("UPDATE cupomtroca set status = ? WHERE ID_Cupom = ?");
					
					pst = connection.prepareStatement(sql.toString());
					pst.setBoolean(1, false);
					pst.setInt(2, c.getId());
					System.out.println(pst);
					pst.executeUpdate();
					connection.commit();
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
			for(Produto p : carrinho.getProdutos())
			{
				System.out.println("Inserindo produto no carrinho: " + carrinhos.get(0).getId());
				try {
					connection.setAutoCommit(false);
					sql = new StringBuilder();
					sql.append("INSERT INTO Produto(ID_Carrinho, ID_Livro, quantidade)");
					sql.append("VALUES (?,?,?)");
					
					pst = connection.prepareStatement(sql.toString());
					pst.setInt(1, carrinhos.get(0).getId());
					pst.setInt(2, p.getLivro().getId());
					pst.setInt(3, p.getQuantidade());
					pst.executeUpdate();
					connection.commit();
					pst.close();
					
					sql = new StringBuilder();
					sql.append("UPDATE Livros set estoque = ? WHERE ID_Livro = ?");
					
					pst = connection.prepareStatement(sql.toString());
					pst.setInt(1, (p.getLivro().getEstoque() - p.getQuantidade()));
					pst.setInt(2, p.getLivro().getId());
					System.out.println(pst);
					pst.executeUpdate();
					connection.commit();
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
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
			sql.append("UPDATE carrinho SET status = ? WHERE ID_Carrinho = ?");
			
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
		sb.append("SELECT * FROM carrinho WHERE 1=1\n");
		if(carrinho.getEmail() != null && carrinho.getEmail().length() > 0)
			sb.append(" AND email_cliente = '" + carrinho.getEmail() + "'");
		if(carrinho.getID_Cliente() > 0)
			sb.append(" AND ID_Cliente = '" + carrinho.getEmail() + "'");
		if(carrinho.getStatus() != null && carrinho.getStatus().length() > 0)
			sb.append(" AND status = '" + carrinho.getStatus() + "'");
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			System.out.println(pst);
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> carrinhos = new ArrayList<>();
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
				//Pegar o endereço de entrega
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
				//Pegar o cartão
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
		}
		return null;
	}
}
