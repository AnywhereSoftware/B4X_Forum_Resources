<?php
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Tqdev\PhpCrudApi\Cache\Cache;
use Tqdev\PhpCrudApi\Column\ReflectionService;
use Tqdev\PhpCrudApi\Controller\Responder;
use Tqdev\PhpCrudApi\Database\GenericDB;
use Tqdev\PhpCrudApi\Middleware\Router\Router;

class SecureQueryController {

    private $responder;
    private $db;

    public function __construct(
        Router $router, 
        Responder $responder, 
        GenericDB $db, 
        ReflectionService $reflection, 
        Cache $cache
    ) {
        $router->register('POST', '/query', array($this, 'executeQuery'));
        $this->responder = $responder;
        $this->db = $db;
    }

    public function executeQuery(ServerRequestInterface $request): ResponseInterface
    {
        try {
            // Parse request body
            $body = json_decode($request->getBody()->getContents(), true);
            
            // Required: SQL query
            $query = $body['query'] ?? null;
            if (empty($query)) {
                return $this->responder->error(400, 'QUERY_REQUIRED', 'Query parameter is required');
            }
            
            // Optional: Parameters for prepared statement
            $params = $body['params'] ?? [];
            
            // Execute the query
            $pdo = $this->db->pdo();
            $stmt = $pdo->prepare($query);
            $stmt->execute($params);

            // Determine query type
            $queryType = strtoupper(trim(explode(' ', $query)[0]));
            
            // Handle different query types
            switch ($queryType) {
                case 'SELECT':
                case 'SHOW':
                case 'DESCRIBE':
                case 'EXPLAIN':
                case 'WITH':
                    $results = $stmt->fetchAll(\PDO::FETCH_ASSOC);
                    return $this->responder->success([
                        'records' => $results,
                        'count' => count($results)
                    ]);
                
                case 'INSERT':
                case 'UPDATE':
                case 'DELETE':
                case 'REPLACE':
                    $affectedRows = $stmt->rowCount();
                    $lastInsertId = $pdo->lastInsertId();
                    
                    return $this->responder->success([
                        'affected_rows' => $affectedRows,
                        'last_insert_id' => $lastInsertId ?: null
                    ]);
                
                case 'CREATE':
                case 'ALTER':
                case 'DROP':
                case 'TRUNCATE':
                case 'RENAME':
                case 'GRANT':
                case 'REVOKE':
                case 'SET':
                case 'USE':
                case 'START':
                case 'COMMIT':
                case 'ROLLBACK':
                case 'SAVEPOINT':
                case 'LOCK':
                case 'UNLOCK':
                    // For DDL commands, return success with affected rows
                    return $this->responder->success([
                        'affected_rows' => $stmt->rowCount(),
                        'message' => 'Command executed successfully'
                    ]);
                
                default:
                    // For any other command type
                    return $this->responder->success([
                        'affected_rows' => $stmt->rowCount(),
                        'message' => 'Command executed successfully'
                    ]);
            }

        } catch (\PDOException $e) {
            // Return error in same format as api.php
            return $this->responder->error(500, 'DATABASE_ERROR', $e->getMessage());
        } catch (\Exception $e) {
            // Return error in same format as api.php
            return $this->responder->error(500, 'INTERNAL_ERROR', $e->getMessage());
        }
    }
}