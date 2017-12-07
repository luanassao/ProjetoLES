package finalCore.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import finalDominio.Cliente;
import finalDominio.EntidadeDominio;

public class ClienteDAO extends AbstractJdbcDAO{
	public ClienteDAO() {
		super("clientes", "id_cliente");
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Cliente cliente = (Cliente)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO clientes(nome, dt_nasc, dt_cadastro, cpf, genero, tipo_tel, telefone, email, senha, status, alterador)");
			sql.append("VALUES (?,?,sysdate(),?,?,?,?,?,?,?,?)");		
			
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, cliente.getNome());
			pst.setDate(2, new Date(cliente.getDtnascimento().getTimeInMillis()), cliente.getDtnascimento());
			pst.setString(3, cliente.getCpf());
			pst.setString(4, cliente.getGenero());
			pst.setString(5, cliente.getTipoTelefone());
			pst.setString(6, cliente.getTelefone());
			pst.setString(7, cliente.getEmail());
			pst.setString(8, cliente.getSenha());
			pst.setBoolean(9, cliente.getStatus());
			pst.setString(10, cliente.getAlterador());
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
	public void alterar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		openConnection();
		PreparedStatement pst = null;
		Cliente cliente = (Cliente)entidade;
		System.out.println("operação de alterar");
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE clientes SET nome = ?, cpf = ?, genero = ?, tipo_tel = ?, telefone = ?, email = ?, senha = ?,");
			sql.append("status = ?, alterador = ? WHERE ID_Cliente = ?");		
			
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, cliente.getNome());
			pst.setString(2, cliente.getCpf());
			pst.setString(3, cliente.getGenero());
			pst.setString(4, cliente.getTipoTelefone());
			pst.setString(5, cliente.getTelefone());
			pst.setString(6, cliente.getEmail());
			pst.setString(7, cliente.getSenha());
			pst.setBoolean(8, cliente.getStatus());
			pst.setString(9, cliente.getAlterador());
			pst.setInt(10, cliente.getId());
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
		// TODO Auto-generated method stub
		PreparedStatement pst = null;
		//Cliente cliente = (Cliente) entidade;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT * FROM clientes WHERE 1=1\n");
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> clientes = new ArrayList<>();
			while(rs.next()){
				Cliente c = new Cliente();
				c.setId(rs.getInt("ID_Cliente"));
				c.setNome(rs.getString("nome"));
				c.setCpf(rs.getString("cpf"));
				c.setStatus(rs.getBoolean("status"));
				c.setGenero(rs.getString("genero"));
				c.setTipoTelefone(rs.getString("tipo_tel"));
				c.setTelefone(rs.getString("telefone"));
				c.setEmail(rs.getString("email"));
				c.setSenha(rs.getString("senha"));
				c.setAlterador(rs.getString("alterador"));
				Calendar calendN = Calendar.getInstance();
				calendN.setTime(rs.getDate("dt_nasc"));
				c.setDtnascimento(calendN);
				Calendar calendC = Calendar.getInstance();
				calendC.setTime(rs.getDate("dt_cadastro"));
				c.setDtCadastro(calendC);
				c.setAdministrador(true);
				System.out.println("status: " + c.getAdministrador());
				clientes.add(c);
			}
			return clientes;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}
}
